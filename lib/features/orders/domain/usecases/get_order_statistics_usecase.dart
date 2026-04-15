import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/orders/domain/entities/order_statistics_entity.dart';
import 'package:laundry/features/orders/domain/repos/orders_repo.dart';

class GetOrderStatisticsUseCase {
  final OrdersRepo _ordersRepo;

  const GetOrderStatisticsUseCase({required OrdersRepo ordersRepo})
    : _ordersRepo = ordersRepo;

  Future<Either<Failure, OrderStatisticsEntity>> call() {
    return _ordersRepo.getStatistics();
  }
}
