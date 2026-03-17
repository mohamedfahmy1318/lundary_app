import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/orders/data/models/order_model.dart';

abstract class OrdersRepo {
  Future<Either<Failure, List<OrderModel>>> getOrders();
  Future<Either<Failure, OrderModel>> getOrderById(int id);
  Future<Either<Failure, OrderModel>> cancelOrder(int id);
  Future<Either<Failure, OrderStatistics>> getStatistics();
}
