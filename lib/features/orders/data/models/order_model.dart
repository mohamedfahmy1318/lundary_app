import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/orders/domain/entities/order_entity.dart';
import 'package:laundry/features/orders/domain/entities/order_item_entity.dart';
import 'package:laundry/features/orders/domain/entities/order_statistics_entity.dart';
import 'package:laundry/features/orders/domain/entities/order_status.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

class OrderStatusJsonConverter implements JsonConverter<OrderStatus, Object?> {
  const OrderStatusJsonConverter();

  @override
  OrderStatus fromJson(Object? json) => _orderStatusFromJson(json);

  @override
  Object? toJson(OrderStatus object) => _orderStatusToJson(object);
}

OrderStatus _orderStatusFromJson(Object? value) {
  final normalized = value
      ?.toString()
      .toLowerCase()
      .replaceAll('-', '_')
      .replaceAll(' ', '_');

  switch (normalized) {
    case 'confirmed':
      return OrderStatus.confirmed;
    case 'picking_up':
      return OrderStatus.pickingUp;
    case 'picked_up':
      return OrderStatus.pickedUp;
    case 'processing':
      return OrderStatus.processing;
    case 'ready':
      return OrderStatus.ready;
    case 'out_for_delivery':
      return OrderStatus.outForDelivery;
    case 'delivered':
      return OrderStatus.delivered;
    case 'completed':
      return OrderStatus.completed;
    case 'cancelled':
      return OrderStatus.cancelled;
    case 'pending':
    default:
      return OrderStatus.pending;
  }
}

String _orderStatusToJson(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return 'pending';
    case OrderStatus.confirmed:
      return 'confirmed';
    case OrderStatus.pickingUp:
      return 'picking_up';
    case OrderStatus.pickedUp:
      return 'picked_up';
    case OrderStatus.processing:
      return 'processing';
    case OrderStatus.ready:
      return 'ready';
    case OrderStatus.outForDelivery:
      return 'out_for_delivery';
    case OrderStatus.delivered:
      return 'delivered';
    case OrderStatus.completed:
      return 'completed';
    case OrderStatus.cancelled:
      return 'cancelled';
  }
}

int _parseInt(Object? value, {int fallback = 0}) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}

String _parseString(Object? value, {String fallback = ''}) {
  final parsed = value?.toString();
  if (parsed == null || parsed.trim().isEmpty || parsed == 'null') {
    return fallback;
  }
  return parsed;
}

String? _parseNullableString(Object? value) {
  final parsed = value?.toString();
  if (parsed == null || parsed.trim().isEmpty || parsed == 'null') {
    return null;
  }
  return parsed;
}

bool _parseBool(Object? value, {bool fallback = false}) {
  if (value is bool) {
    return value;
  }
  final normalized = value?.toString().toLowerCase();
  if (normalized == '1' || normalized == 'true' || normalized == 'yes') {
    return true;
  }
  if (normalized == '0' || normalized == 'false' || normalized == 'no') {
    return false;
  }
  return fallback;
}

@freezed
abstract class OrderItemModel extends OrderItemEntity with _$OrderItemModel {
  const OrderItemModel._();

  const factory OrderItemModel({
    required int id,
    @JsonKey(name: 'order_id') required int orderId,
    @JsonKey(name: 'service_id') required int serviceId,
    @JsonKey(name: 'service_name') required String serviceName,
    required int quantity,
    @JsonKey(name: 'unit_price') required String unitPrice,
    @JsonKey(name: 'total_price') required String totalPrice,
    @JsonKey(name: 'special_instructions') String? specialInstructions,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return <String, dynamic>{
      ...json,
      'id': _parseInt(json['id']),
      'order_id': _parseInt(json['order_id'] ?? json['orderId']),
      'service_id': _parseInt(json['service_id'] ?? json['serviceId']),
      'service_name': _parseString(json['service_name'] ?? json['serviceName']),
      'quantity': _parseInt(json['quantity']),
      'unit_price': _parseString(json['unit_price'] ?? json['unitPrice']),
      'total_price': _parseString(json['total_price'] ?? json['totalPrice']),
      'special_instructions': _parseNullableString(
        json['special_instructions'] ?? json['specialInstructions'],
      ),
    };
  }
}

@freezed
abstract class OrderModel extends OrderEntity with _$OrderModel {
  const OrderModel._();

  const factory OrderModel({
    required int id,
    @JsonKey(name: 'order_number') required String orderNumber,
    @JsonKey(name: 'user_id') required int userId,
    @OrderStatusJsonConverter() required OrderStatus status,
    @JsonKey(name: 'pickup_date') String? pickupDate,
    @JsonKey(name: 'pickup_time_slot') String? pickupTimeSlot,
    @JsonKey(name: 'pickup_address') String? pickupAddress,
    @JsonKey(name: 'delivery_date') String? deliveryDate,
    @JsonKey(name: 'delivery_time_slot') String? deliveryTimeSlot,
    @JsonKey(name: 'delivery_address') String? deliveryAddress,
    required String subtotal,
    @JsonKey(name: 'delivery_fee') required String deliveryFee,
    @JsonKey(name: 'discount_amount') required String discountAmount,
    @JsonKey(name: 'total_amount') required String totalAmount,
    @JsonKey(name: 'payment_method') String? paymentMethod,
    @JsonKey(name: 'payment_status') String? paymentStatus,
    String? notes,
    @JsonKey(name: 'promo_code') String? promoCode,
    @JsonKey(name: 'is_express') @Default(false) bool isExpress,
    @JsonKey(name: 'cancelled_at') String? cancelledAt,
    @JsonKey(name: 'cancellation_reason') String? cancellationReason,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    List<OrderItemModel>? items,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final rawItems = json['items'];
    final normalizedItems =
        rawItems is List
            ? rawItems.whereType<Map>().map((item) {
              return OrderItemModel._normalizeJson(
                Map<String, dynamic>.from(item),
              );
            }).toList()
            : null;

    return <String, dynamic>{
      ...json,
      'id': _parseInt(json['id']),
      'order_number': _parseString(json['order_number'] ?? json['orderNumber']),
      'user_id': _parseInt(json['user_id'] ?? json['userId']),
      'status': json['status'],
      'pickup_date': _parseNullableString(
        json['pickup_date'] ?? json['pickupDate'],
      ),
      'pickup_time_slot': _parseNullableString(
        json['pickup_time_slot'] ?? json['pickupTimeSlot'],
      ),
      'pickup_address': _parseNullableString(
        json['pickup_address'] ?? json['pickupAddress'],
      ),
      'delivery_date': _parseNullableString(
        json['delivery_date'] ?? json['deliveryDate'],
      ),
      'delivery_time_slot': _parseNullableString(
        json['delivery_time_slot'] ?? json['deliveryTimeSlot'],
      ),
      'delivery_address': _parseNullableString(
        json['delivery_address'] ?? json['deliveryAddress'],
      ),
      'subtotal': _parseString(json['subtotal'], fallback: '0'),
      'delivery_fee': _parseString(
        json['delivery_fee'] ?? json['deliveryFee'],
        fallback: '0',
      ),
      'discount_amount': _parseString(
        json['discount_amount'] ?? json['discountAmount'],
        fallback: '0',
      ),
      'total_amount': _parseString(
        json['total_amount'] ?? json['totalAmount'] ?? json['total'],
        fallback: '0',
      ),
      'payment_method': _parseNullableString(
        json['payment_method'] ?? json['paymentMethod'],
      ),
      'payment_status': _parseNullableString(
        json['payment_status'] ?? json['paymentStatus'],
      ),
      'notes': _parseNullableString(json['notes']),
      'promo_code': _parseNullableString(
        json['promo_code'] ?? json['promoCode'],
      ),
      'is_express': _parseBool(json['is_express'] ?? json['isExpress']),
      'cancelled_at': _parseNullableString(
        json['cancelled_at'] ?? json['cancelledAt'],
      ),
      'cancellation_reason': _parseNullableString(
        json['cancellation_reason'] ?? json['cancellationReason'],
      ),
      'created_at': _parseNullableString(
        json['created_at'] ?? json['createdAt'],
      ),
      'updated_at': _parseNullableString(
        json['updated_at'] ?? json['updatedAt'],
      ),
      'items': normalizedItems,
    };
  }
}

@freezed
abstract class OrderStatisticsModel extends OrderStatisticsEntity
    with _$OrderStatisticsModel {
  const OrderStatisticsModel._();

  const factory OrderStatisticsModel({
    @JsonKey(name: 'total_orders') required int totalOrders,
    @JsonKey(name: 'pending_orders') required int pendingOrders,
    @JsonKey(name: 'completed_orders') required int completedOrders,
    @JsonKey(name: 'total_spent') required int totalSpent,
  }) = _OrderStatisticsModel;

  factory OrderStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$OrderStatisticsModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return <String, dynamic>{
      ...json,
      'total_orders': _parseInt(json['total_orders'] ?? json['totalOrders']),
      'pending_orders': _parseInt(
        json['pending_orders'] ?? json['pendingOrders'],
      ),
      'completed_orders': _parseInt(
        json['completed_orders'] ?? json['completedOrders'],
      ),
      'total_spent': _parseInt(json['total_spent'] ?? json['totalSpent']),
    };
  }
}
