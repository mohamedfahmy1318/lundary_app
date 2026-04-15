// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_order_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateOrderRequestModel _$CreateOrderRequestModelFromJson(
  Map<String, dynamic> json,
) => _CreateOrderRequestModel(
  items:
      (json['items'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  pickupDate: json['pickup_date'] as String,
  pickupTimeSlot: json['pickup_time_slot'] as String,
  deliveryDate: json['delivery_date'] as String,
  deliveryTimeSlot: json['delivery_time_slot'] as String,
  pickupAddress: json['pickup_address'] as String,
  deliveryAddress: json['delivery_address'] as String,
  paymentMethod: json['payment_method'] as String,
  isExpress: json['is_express'] as bool? ?? false,
  promoCode: json['promo_code'] as String?,
  notesPickup: json['notes_pickup'] as String?,
  notesDelivery: json['notes_delivery'] as String?,
);

Map<String, dynamic> _$CreateOrderRequestModelToJson(
  _CreateOrderRequestModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'pickup_date': instance.pickupDate,
  'pickup_time_slot': instance.pickupTimeSlot,
  'delivery_date': instance.deliveryDate,
  'delivery_time_slot': instance.deliveryTimeSlot,
  'pickup_address': instance.pickupAddress,
  'delivery_address': instance.deliveryAddress,
  'payment_method': instance.paymentMethod,
  'is_express': instance.isExpress,
  'promo_code': instance.promoCode,
  'notes_pickup': instance.notesPickup,
  'notes_delivery': instance.notesDelivery,
};

_CreateOrderResponseModel _$CreateOrderResponseModelFromJson(
  Map<String, dynamic> json,
) => _CreateOrderResponseModel(
  success: json['success'] as bool,
  message: json['message'] as String,
  orderId: (json['order_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$CreateOrderResponseModelToJson(
  _CreateOrderResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'order_id': instance.orderId,
};
