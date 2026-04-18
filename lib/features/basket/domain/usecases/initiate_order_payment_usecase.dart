import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/basket/domain/entities/payment_initiation_entity.dart';
import 'package:laundry/features/basket/domain/repos/basket_repo.dart';

class InitiateOrderPaymentParams extends Equatable {
  final int orderId;

  const InitiateOrderPaymentParams({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}

class InitiateOrderPaymentUseCase {
  final BasketRepo _basketRepo;

  const InitiateOrderPaymentUseCase({required BasketRepo basketRepo})
    : _basketRepo = basketRepo;

  Future<Either<Failure, PaymentInitiationEntity>> call(
    InitiateOrderPaymentParams params,
  ) {
    return _basketRepo.initiateOrderPayment(params.orderId);
  }
}
