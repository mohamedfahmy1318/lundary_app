import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/orders/domain/entities/order_entity.dart';
import 'package:laundry/features/orders/domain/repos/orders_repo.dart';

class GetOrdersUseCase {
  final OrdersRepo _ordersRepo;

  const GetOrdersUseCase({required OrdersRepo ordersRepo})
    : _ordersRepo = ordersRepo;

  Future<Either<Failure, List<OrderEntity>>> call() {
    return _ordersRepo.getOrders();
  }
}
