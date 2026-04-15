import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/orders/domain/entities/order_entity.dart';
import 'package:laundry/features/orders/domain/entities/order_statistics_entity.dart';

abstract class OrdersRepo {
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, OrderEntity>> getOrderById(int id);
  Future<Either<Failure, OrderEntity>> cancelOrder(int id);
  Future<Either<Failure, OrderStatisticsEntity>> getStatistics();
}
