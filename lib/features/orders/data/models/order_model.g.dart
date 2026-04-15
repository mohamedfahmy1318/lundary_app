// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    _OrderItemModel(
      id: (json['id'] as num).toInt(),
      orderId: (json['order_id'] as num).toInt(),
      serviceId: (json['service_id'] as num).toInt(),
      serviceName: json['service_name'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: json['unit_price'] as String,
      totalPrice: json['total_price'] as String,
      specialInstructions: json['special_instructions'] as String?,
    );

Map<String, dynamic> _$OrderItemModelToJson(_OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'service_id': instance.serviceId,
      'service_name': instance.serviceName,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'total_price': instance.totalPrice,
      'special_instructions': instance.specialInstructions,
    };

_OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => _OrderModel(
  id: (json['id'] as num).toInt(),
  orderNumber: json['order_number'] as String,
  userId: (json['user_id'] as num).toInt(),
  status: const OrderStatusJsonConverter().fromJson(json['status']),
  pickupDate: json['pickup_date'] as String?,
  pickupTimeSlot: json['pickup_time_slot'] as String?,
  pickupAddress: json['pickup_address'] as String?,
  deliveryDate: json['delivery_date'] as String?,
  deliveryTimeSlot: json['delivery_time_slot'] as String?,
  deliveryAddress: json['delivery_address'] as String?,
  subtotal: json['subtotal'] as String,
  deliveryFee: json['delivery_fee'] as String,
  discountAmount: json['discount_amount'] as String,
  totalAmount: json['total_amount'] as String,
  paymentMethod: json['payment_method'] as String?,
  paymentStatus: json['payment_status'] as String?,
  notes: json['notes'] as String?,
  promoCode: json['promo_code'] as String?,
  isExpress: json['is_express'] as bool? ?? false,
  cancelledAt: json['cancelled_at'] as String?,
  cancellationReason: json['cancellation_reason'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$OrderModelToJson(_OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'user_id': instance.userId,
      'status': const OrderStatusJsonConverter().toJson(instance.status),
      'pickup_date': instance.pickupDate,
      'pickup_time_slot': instance.pickupTimeSlot,
      'pickup_address': instance.pickupAddress,
      'delivery_date': instance.deliveryDate,
      'delivery_time_slot': instance.deliveryTimeSlot,
      'delivery_address': instance.deliveryAddress,
      'subtotal': instance.subtotal,
      'delivery_fee': instance.deliveryFee,
      'discount_amount': instance.discountAmount,
      'total_amount': instance.totalAmount,
      'payment_method': instance.paymentMethod,
      'payment_status': instance.paymentStatus,
      'notes': instance.notes,
      'promo_code': instance.promoCode,
      'is_express': instance.isExpress,
      'cancelled_at': instance.cancelledAt,
      'cancellation_reason': instance.cancellationReason,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'items': instance.items,
    };

_OrderStatisticsModel _$OrderStatisticsModelFromJson(
  Map<String, dynamic> json,
) => _OrderStatisticsModel(
  totalOrders: (json['total_orders'] as num).toInt(),
  pendingOrders: (json['pending_orders'] as num).toInt(),
  completedOrders: (json['completed_orders'] as num).toInt(),
  totalSpent: (json['total_spent'] as num).toInt(),
);

Map<String, dynamic> _$OrderStatisticsModelToJson(
  _OrderStatisticsModel instance,
) => <String, dynamic>{
  'total_orders': instance.totalOrders,
  'pending_orders': instance.pendingOrders,
  'completed_orders': instance.completedOrders,
  'total_spent': instance.totalSpent,
};
