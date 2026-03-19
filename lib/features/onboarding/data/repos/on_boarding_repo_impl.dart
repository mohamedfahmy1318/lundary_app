import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repos/on_boarding_repo.dart';
import '../models/on_boarding_model.dart';
import '../data_sources/on_boarding_remote_data_source.dart';

class OnBoardingRepoImpl implements OnBoardingRepo {
  final OnBoardingRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  OnBoardingRepoImpl({required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<OnBoardingModel>>> getOnboardingData() async {
    if (!await networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final data = await remoteDataSource.getOnboardingData();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
