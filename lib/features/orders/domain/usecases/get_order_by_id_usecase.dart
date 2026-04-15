import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/orders/domain/entities/order_entity.dart';
import 'package:laundry/features/orders/domain/repos/orders_repo.dart';

class GetOrderByIdParams extends Equatable {
  final int orderId;

  const GetOrderByIdParams({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class GetOrderByIdUseCase {
  final OrdersRepo _ordersRepo;

  const GetOrderByIdUseCase({required OrdersRepo ordersRepo})
    : _ordersRepo = ordersRepo;

  Future<Either<Failure, OrderEntity>> call(GetOrderByIdParams params) {
    return _ordersRepo.getOrderById(params.orderId);
  }
}
