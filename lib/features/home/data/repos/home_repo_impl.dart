import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:laundry/features/home/data/models/category_model.dart';
import 'package:laundry/features/home/data/models/service_model.dart';
import 'package:laundry/features/home/domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  HomeRepoImpl({
    required HomeRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final categories = await _remoteDataSource.getCategories();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ServiceModel>>> getServices({
    int? categoryId,
    String? search,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final services = await _remoteDataSource.getServices(
        categoryId: categoryId,
        search: search,
      );
      return Right(services);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
