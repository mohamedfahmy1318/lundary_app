import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/features/basket/data/data_sources/basket_remote_data_source.dart';
import 'package:laundry/features/basket/data/models/basket_item_model.dart';
import 'package:laundry/features/basket/domain/repos/basket_repo.dart';

class BasketRepoImpl implements BasketRepo {
  final BasketRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  BasketRepoImpl({
    required BasketRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<BasketItemModel>>> getServices() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final items = await _remoteDataSource.getServices();
      return Right(items);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createOrder(
    Map<String, dynamic> orderData,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final result = await _remoteDataSource.createOrder(orderData);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
