import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/profile/domain/entities/active_subscription_entity.dart';
import 'package:laundry/features/profile/domain/entities/profile_entity.dart';
import 'package:laundry/features/profile/domain/entities/subscription_plan_entity.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

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

List<String> _parseAddressList(Object? value) {
  if (value is! List) {
    return const <String>[];
  }

  final addresses = <String>[];
  final seen = <String>{};

  for (final item in value) {
    String? parsed;

    if (item is String) {
      parsed = item.trim();
    } else if (item is Map<String, dynamic>) {
      parsed =
          item['address']?.toString().trim() ??
          item['name']?.toString().trim() ??
          item['label']?.toString().trim();
    } else if (item is Map) {
      parsed =
          item['address']?.toString().trim() ??
          item['name']?.toString().trim() ??
          item['label']?.toString().trim();
    } else {
      parsed = item?.toString().trim();
    }

    if (parsed == null || parsed.isEmpty || parsed == 'null') {
      continue;
    }

    final normalized = parsed.toLowerCase();
    if (seen.add(normalized)) {
      addresses.add(parsed);
    }
  }

  return addresses;
}

bool _parseBool(Object? value, {bool fallback = false}) {
  if (value is bool) {
    return value;
  }
  final normalized = value?.toString().trim().toLowerCase();
  if (normalized == '1' || normalized == 'true' || normalized == 'yes') {
    return true;
  }
  if (normalized == '0' || normalized == 'false' || normalized == 'no') {
    return false;
  }
  return fallback;
}

@freezed
abstract class SubscriptionPlanModel extends SubscriptionPlanEntity
    with _$SubscriptionPlanModel {
  const SubscriptionPlanModel._();

  const factory SubscriptionPlanModel({
    required int id,
    required String name,
    required String slug,
    String? description,
    required String price,
    @JsonKey(name: 'duration_days') required int durationDays,
    @JsonKey(name: 'item_limit') required int itemLimit,
    @JsonKey(name: 'unlimited_items') required bool unlimitedItems,
    @JsonKey(name: 'free_delivery') required bool freeDelivery,
    @JsonKey(name: 'express_service') required bool expressService,
    @JsonKey(name: 'priority_support') required bool prioritySupport,
    @JsonKey(name: 'discount_percentage') required int discountPercentage,
    @JsonKey(name: 'is_active') required bool isActive,
  }) = _SubscriptionPlanModel;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return <String, dynamic>{
      ...json,
      'id': _parseInt(json['id']),
      'name': _parseString(json['name']),
      'slug': _parseString(json['slug']),
      'description': _parseNullableString(json['description']),
      'price': _parseString(json['price'], fallback: '0'),
      'duration_days': _parseInt(json['duration_days'] ?? json['durationDays']),
      'item_limit': _parseInt(json['item_limit'] ?? json['itemLimit']),
      'unlimited_items': _parseBool(
        json['unlimited_items'] ?? json['unlimitedItems'],
      ),
      'free_delivery': _parseBool(
        json['free_delivery'] ?? json['freeDelivery'],
      ),
      'express_service': _parseBool(
        json['express_service'] ?? json['expressService'],
      ),
      'priority_support': _parseBool(
        json['priority_support'] ?? json['prioritySupport'],
      ),
      'discount_percentage': _parseInt(
        json['discount_percentage'] ?? json['discountPercentage'],
      ),
      'is_active': _parseBool(json['is_active'] ?? json['isActive']),
    };
  }
}

@freezed
abstract class ActiveSubscriptionModel extends ActiveSubscriptionEntity
    with _$ActiveSubscriptionModel {
  const ActiveSubscriptionModel._();

  const factory ActiveSubscriptionModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'plan_id') required int planId,
    @JsonKey(name: 'starts_at') required String startsAt,
    @JsonKey(name: 'ends_at') required String endsAt,
    @JsonKey(name: 'items_used') required int itemsUsed,
    required String status,
    @JsonKey(name: 'amount_paid') required String amountPaid,
    required SubscriptionPlanModel plan,
  }) = _ActiveSubscriptionModel;

  factory ActiveSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveSubscriptionModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final planJson = json['plan'];

    return <String, dynamic>{
      ...json,
      'id': _parseInt(json['id']),
      'user_id': _parseInt(json['user_id'] ?? json['userId']),
      'plan_id': _parseInt(json['plan_id'] ?? json['planId']),
      'starts_at': _parseString(json['starts_at'] ?? json['startsAt']),
      'ends_at': _parseString(json['ends_at'] ?? json['endsAt']),
      'items_used': _parseInt(json['items_used'] ?? json['itemsUsed']),
      'status': _parseString(json['status']),
      'amount_paid': _parseString(
        json['amount_paid'] ?? json['amountPaid'],
        fallback: '0',
      ),
      'plan':
          planJson is Map
              ? SubscriptionPlanModel._normalizeJson(
                Map<String, dynamic>.from(planJson),
              )
              : <String, dynamic>{},
    };
  }
}

@freezed
abstract class ProfileModel extends ProfileEntity with _$ProfileModel {
  const ProfileModel._();

  const factory ProfileModel({
    required int id,
    required String name,
    required String email,
    required String phone,
    @JsonKey(name: 'wallet_balance') String? walletBalance,
    String? avatar,
    @Default(<String>[]) List<String> addresses,
    @JsonKey(name: 'active_subscription')
    ActiveSubscriptionModel? activeSubscription,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final activeSubscriptionJson =
        json['active_subscription'] ?? json['activeSubscription'];

    return <String, dynamic>{
      ...json,
      'id': _parseInt(json['id']),
      'name': _parseString(json['name']),
      'email': _parseString(json['email']),
      'phone': _parseString(json['phone']),
      'wallet_balance': _parseNullableString(
        json['wallet_balance'] ?? json['walletBalance'],
      ),
      'avatar': _parseNullableString(json['avatar']),
      'addresses': _parseAddressList(json['addresses']),
      'active_subscription':
          activeSubscriptionJson is Map
              ? ActiveSubscriptionModel._normalizeJson(
                Map<String, dynamic>.from(activeSubscriptionJson),
              )
              : null,
    };
  }
}
