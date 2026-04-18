import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:laundry/features/basket/data/models/cart_item.dart';
import 'package:laundry/features/basket/domain/entities/order_request_entity.dart';
import 'package:laundry/features/basket/domain/entities/order_response_entity.dart';

part 'create_order_models.freezed.dart';
part 'create_order_models.g.dart';

@freezed
abstract class CreateOrderRequestModel with _$CreateOrderRequestModel {
  const CreateOrderRequestModel._();

  const factory CreateOrderRequestModel({
    required List<CartItemModel> items,
    @JsonKey(name: 'pickup_date') required String pickupDate,
    @JsonKey(name: 'pickup_time_slot') required String pickupTimeSlot,
    @JsonKey(name: 'delivery_date') required String deliveryDate,
    @JsonKey(name: 'delivery_time_slot') required String deliveryTimeSlot,
    @JsonKey(name: 'pickup_address') required String pickupAddress,
    @JsonKey(name: 'delivery_address') required String deliveryAddress,
    @JsonKey(name: 'payment_method') required String paymentMethod,
    @JsonKey(name: 'is_express') @Default(false) bool isExpress,
    @JsonKey(name: 'promo_code') String? promoCode,
    @JsonKey(name: 'notes_pickup') String? notesPickup,
    @JsonKey(name: 'notes_delivery') String? notesDelivery,
  }) = _CreateOrderRequestModel;

  factory CreateOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestModelFromJson(json);

  factory CreateOrderRequestModel.fromEntity(CreateOrderRequestEntity entity) {
    return CreateOrderRequestModel(
      items: entity.items.map(CartItemModel.fromEntity).toList(),
      pickupDate: entity.pickupDate,
      pickupTimeSlot: entity.pickupTimeSlot,
      deliveryDate: entity.deliveryDate,
      deliveryTimeSlot: entity.deliveryTimeSlot,
      pickupAddress: entity.pickupAddress,
      deliveryAddress: entity.deliveryAddress,
      paymentMethod: entity.paymentMethod,
      isExpress: entity.isExpress,
      promoCode: entity.promoCode,
      notesPickup: entity.notesPickup,
      notesDelivery: entity.notesDelivery,
    );
  }

  Map<String, dynamic> toApiJson() {
    final json = toJson();
    json['items'] = items.map((item) => item.toOrderJson()).toList();
    json.removeWhere((key, value) {
      if (value == null) {
        return true;
      }
      if (value is String && value.trim().isEmpty) {
        return true;
      }
      return false;
    });
    return json;
  }
}

@freezed
abstract class CreateOrderResponseModel extends OrderResponseEntity
    with _$CreateOrderResponseModel {
  const CreateOrderResponseModel._();

  const factory CreateOrderResponseModel({
    required bool success,
    required String message,
    @JsonKey(name: 'order_id') int? orderId,
    @JsonKey(name: 'order_number') String? orderNumber,
  }) = _CreateOrderResponseModel;

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderResponseModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final data = _extractMap(json['data']);
    final orderId = _extractOrderId(data) ?? _parseInt(json['order_id']);
    final orderNumber =
        _parseString(data?['order_number']) ??
        _parseString(json['order_number']);

    return <String, dynamic>{
      ...json,
      'success': _parseBool(json['success'], fallback: true),
      'message': (json['message'] ?? 'Order created successfully').toString(),
      'order_id': orderId,
      'order_number': orderNumber,
    };
  }

  static int? _extractOrderId(Map<String, dynamic>? data) =>
      _parseInt(data?['id'] ?? data?['order_id']);

  static Map<String, dynamic>? _extractMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return value;
    }
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return null;
  }

  static int? _parseInt(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '');
  }

  static String? _parseString(Object? value) {
    final result = value?.toString();
    if (result == null || result.trim().isEmpty || result == 'null') {
      return null;
    }
    return result;
  }

  static bool _parseBool(Object? value, {required bool fallback}) {
    if (value is bool) {
      return value;
    }
    final normalized = value?.toString().trim().toLowerCase();
    if (normalized == '1' || normalized == 'true') {
      return true;
    }
    if (normalized == '0' || normalized == 'false') {
      return false;
    }
    return fallback;
  }
}
