import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/features/orders/data/data_sources/orders_local_data_source.dart';
import 'package:laundry/features/orders/data/data_sources/orders_remote_data_source.dart';
import 'package:laundry/features/orders/data/models/order_model.dart';
import 'package:laundry/features/orders/domain/entities/order_entity.dart';
import 'package:laundry/features/orders/domain/entities/order_statistics_entity.dart';
import 'package:laundry/features/orders/domain/repos/orders_repo.dart';

class OrdersRepoImpl implements OrdersRepo {
  final OrdersRemoteDataSource _remoteDataSource;
  final OrdersLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  OrdersRepoImpl({
    required OrdersRemoteDataSource remoteDataSource,
    required OrdersLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final orders = await _remoteDataSource.getOrders();
        await _localDataSource.cacheOrders(orders);
        for (final order in orders) {
          await _localDataSource.cacheOrder(order);
        }
        return Right(orders);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedOrders();
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedOrders();
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedOrders();
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderById(int id) async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final order = await _remoteDataSource.getOrderById(id);
        await _localDataSource.cacheOrder(order);
        return Right(order);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedOrder(id);
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedOrder(id);
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedOrder(id);
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, OrderEntity>> cancelOrder(int id) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final order = await _remoteDataSource.cancelOrder(id);
      await _localDataSource.cacheOrder(order);
      return Right(order);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OrderStatisticsEntity>> getStatistics() async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final stats = await _remoteDataSource.getStatistics();
        await _localDataSource.cacheStatistics(stats);
        return Right(stats);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedStatistics();
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedStatistics();
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedStatistics();
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  Future<List<OrderModel>?> _tryGetCachedOrders() async {
    try {
      return await _localDataSource.getCachedOrders();
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<OrderModel?> _tryGetCachedOrder(int orderId) async {
    try {
      return await _localDataSource.getCachedOrderById(orderId);
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<OrderStatisticsModel?> _tryGetCachedStatistics() async {
    try {
      return await _localDataSource.getCachedStatistics();
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
