import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/features/orders/data/data_sources/orders_remote_data_source.dart';
import 'package:laundry/features/orders/data/models/order_model.dart';
import 'package:laundry/features/orders/domain/repos/orders_repo.dart';

class OrdersRepoImpl implements OrdersRepo {
  final OrdersRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  OrdersRepoImpl({
    required OrdersRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<OrderModel>>> getOrders() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final orders = await _remoteDataSource.getOrders();
      return Right(orders);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderModel>> getOrderById(String id) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final order = await _remoteDataSource.getOrderById(id);
      return Right(order);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
