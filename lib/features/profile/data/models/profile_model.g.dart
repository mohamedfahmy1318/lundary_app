// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionPlanModel _$SubscriptionPlanModelFromJson(
  Map<String, dynamic> json,
) => _SubscriptionPlanModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String,
  description: json['description'] as String?,
  price: json['price'] as String,
  durationDays: (json['duration_days'] as num).toInt(),
  itemLimit: (json['item_limit'] as num).toInt(),
  unlimitedItems: json['unlimited_items'] as bool,
  freeDelivery: json['free_delivery'] as bool,
  expressService: json['express_service'] as bool,
  prioritySupport: json['priority_support'] as bool,
  discountPercentage: (json['discount_percentage'] as num).toInt(),
  isActive: json['is_active'] as bool,
);

Map<String, dynamic> _$SubscriptionPlanModelToJson(
  _SubscriptionPlanModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'description': instance.description,
  'price': instance.price,
  'duration_days': instance.durationDays,
  'item_limit': instance.itemLimit,
  'unlimited_items': instance.unlimitedItems,
  'free_delivery': instance.freeDelivery,
  'express_service': instance.expressService,
  'priority_support': instance.prioritySupport,
  'discount_percentage': instance.discountPercentage,
  'is_active': instance.isActive,
};

_ActiveSubscriptionModel _$ActiveSubscriptionModelFromJson(
  Map<String, dynamic> json,
) => _ActiveSubscriptionModel(
  id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  planId: (json['plan_id'] as num).toInt(),
  startsAt: json['starts_at'] as String,
  endsAt: json['ends_at'] as String,
  itemsUsed: (json['items_used'] as num).toInt(),
  status: json['status'] as String,
  amountPaid: json['amount_paid'] as String,
  plan: SubscriptionPlanModel.fromJson(json['plan'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ActiveSubscriptionModelToJson(
  _ActiveSubscriptionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'plan_id': instance.planId,
  'starts_at': instance.startsAt,
  'ends_at': instance.endsAt,
  'items_used': instance.itemsUsed,
  'status': instance.status,
  'amount_paid': instance.amountPaid,
  'plan': instance.plan,
};

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) =>
    _ProfileModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      walletBalance: json['wallet_balance'] as String?,
      avatar: json['avatar'] as String?,
      addresses:
          (json['addresses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      activeSubscription:
          json['active_subscription'] == null
              ? null
              : ActiveSubscriptionModel.fromJson(
                json['active_subscription'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'wallet_balance': instance.walletBalance,
      'avatar': instance.avatar,
      'addresses': instance.addresses,
      'active_subscription': instance.activeSubscription,
    };
