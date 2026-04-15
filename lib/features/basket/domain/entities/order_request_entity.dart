import 'package:equatable/equatable.dart';

import 'package:laundry/features/basket/domain/entities/cart_item_entity.dart';

class CreateOrderRequestEntity extends Equatable {
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

  const CreateOrderRequestEntity({
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
