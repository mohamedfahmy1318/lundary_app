import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../data_sources/on_boarding_local_data_source.dart';
import '../data_sources/on_boarding_remote_data_source.dart';
import '../../domain/repos/on_boarding_repo.dart';
import '../../domain/entities/on_boarding_slide_entity.dart';
import '../models/on_boarding_model.dart';

class OnBoardingRepoImpl implements OnBoardingRepo {
  final OnBoardingRemoteDataSource _remoteDataSource;
  final OnBoardingLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  OnBoardingRepoImpl({
    required OnBoardingRemoteDataSource remoteDataSource,
    required OnBoardingLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<OnBoardingSlideEntity>>>
  getOnboardingData() async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final remoteSlides = await _remoteDataSource.getOnboardingData();
        await _localDataSource.cacheSlides(remoteSlides);
        return Right(remoteSlides);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedSlides();
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedSlides();
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedSlides();
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  Future<List<OnBoardingModel>?> _tryGetCachedSlides() async {
    try {
      return await _localDataSource.getCachedSlides();
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
