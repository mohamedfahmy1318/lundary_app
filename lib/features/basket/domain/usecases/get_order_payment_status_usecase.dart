import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/basket/domain/entities/payment_status_entity.dart';
import 'package:laundry/features/basket/domain/repos/basket_repo.dart';

class GetOrderPaymentStatusParams extends Equatable {
  final int orderId;

  const GetOrderPaymentStatusParams({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class GetOrderPaymentStatusUseCase {
  final BasketRepo _basketRepo;

  const GetOrderPaymentStatusUseCase({required BasketRepo basketRepo})
    : _basketRepo = basketRepo;

  Future<Either<Failure, PaymentStatusEntity>> call(
    GetOrderPaymentStatusParams params,
  ) {
    return _basketRepo.getOrderPaymentStatus(params.orderId);
  }
}
