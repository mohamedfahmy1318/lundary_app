import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/orders/domain/entities/order_entity.dart';
import 'package:laundry/features/orders/domain/repos/orders_repo.dart';

class CancelOrderParams extends Equatable {
  final int orderId;

  const CancelOrderParams({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class CancelOrderUseCase {
  final OrdersRepo _ordersRepo;

  const CancelOrderUseCase({required OrdersRepo ordersRepo})
    : _ordersRepo = ordersRepo;

  Future<Either<Failure, OrderEntity>> call(CancelOrderParams params) {
    return _ordersRepo.cancelOrder(params.orderId);
  }
}
