import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/basket/domain/entities/cart_item_entity.dart';
import 'package:laundry/features/basket/domain/entities/order_request_entity.dart';
import 'package:laundry/features/basket/domain/entities/order_response_entity.dart';
import 'package:laundry/features/basket/domain/repos/basket_repo.dart';

class CreateOrderParams extends Equatable {
  final List<CartItemEntity> items;
  final String pickupDate;
  final String pickupTimeSlot;
  final String deliveryDate;
  final String deliveryTimeSlot;
  final String pickupAddress;
  final String deliveryAddress;
  final String paymentMethod;
  final bool isExpress;
  final String? promoCode;
  final String? notesPickup;
  final String? notesDelivery;

  const CreateOrderParams({
    required this.items,
    required this.pickupDate,
    required this.pickupTimeSlot,
    required this.deliveryDate,
    required this.deliveryTimeSlot,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.paymentMethod,
    this.isExpress = false,
    this.promoCode,
    this.notesPickup,
    this.notesDelivery,
  });

  CreateOrderRequestEntity toEntity() {
    return CreateOrderRequestEntity(
      items: items,
      pickupDate: pickupDate,
      pickupTimeSlot: pickupTimeSlot,
      deliveryDate: deliveryDate,
      deliveryTimeSlot: deliveryTimeSlot,
      pickupAddress: pickupAddress,
      deliveryAddress: deliveryAddress,
      paymentMethod: paymentMethod,
      isExpress: isExpress,
      promoCode: promoCode,
      notesPickup: notesPickup,
      notesDelivery: notesDelivery,
    );
  }

  @override
  List<Object?> get props => [
    items,
    pickupDate,
    pickupTimeSlot,
    deliveryDate,
    deliveryTimeSlot,
    pickupAddress,
    deliveryAddress,
    paymentMethod,
    isExpress,
    promoCode,
    notesPickup,
    notesDelivery,
  ];
}

class CreateOrderUseCase {
  final BasketRepo _basketRepo;

  const CreateOrderUseCase({required BasketRepo basketRepo})
    : _basketRepo = basketRepo;

  Future<Either<Failure, OrderResponseEntity>> call(CreateOrderParams params) {
    return _basketRepo.createOrder(params.toEntity());
  }
}
