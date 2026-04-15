import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/features/basket/data/data_sources/basket_local_data_source.dart';
import 'package:laundry/features/basket/data/data_sources/basket_remote_data_source.dart';
import 'package:laundry/features/basket/data/models/create_order_models.dart';
import 'package:laundry/features/basket/domain/entities/order_request_entity.dart';
import 'package:laundry/features/basket/domain/entities/order_response_entity.dart';
import 'package:laundry/features/basket/domain/entities/time_slot_entity.dart';
import 'package:laundry/features/basket/domain/repos/basket_repo.dart';

class BasketRepoImpl implements BasketRepo {
  final BasketRemoteDataSource _remoteDataSource;
  final BasketLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  BasketRepoImpl({
    required BasketRemoteDataSource remoteDataSource,
    required BasketLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, OrderResponseEntity>> createOrder(
    CreateOrderRequestEntity orderData,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final requestModel = CreateOrderRequestModel.fromEntity(orderData);
      final result = await _remoteDataSource.createOrder(requestModel);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TimeSlotEntity>>> getTimeslots(
    String date,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final result = await _remoteDataSource.getTimeslots(date);
        await _localDataSource.cacheTimeslots(date, result);
        return Right(result);
      } on ServerException catch (e) {
        final cached = _localDataSource.getCachedTimeslots(date);
        if (cached != null && cached.isNotEmpty) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = _localDataSource.getCachedTimeslots(date);
        if (cached != null && cached.isNotEmpty) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = _localDataSource.getCachedTimeslots(date);
    if (cached != null && cached.isNotEmpty) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }
}
