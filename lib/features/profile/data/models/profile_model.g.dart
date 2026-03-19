// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  walletBalance: json['wallet_balance'] as String?,
  avatar: json['avatar'] as String?,
  activeSubscription:
      json['active_subscription'] == null
          ? null
          : ActiveSubscription.fromJson(
            json['active_subscription'] as Map<String, dynamic>,
          ),
);

ActiveSubscription _$ActiveSubscriptionFromJson(Map<String, dynamic> json) =>
    ActiveSubscription(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      planId: (json['plan_id'] as num).toInt(),
      startsAt: json['starts_at'] as String,
      endsAt: json['ends_at'] as String,
      itemsUsed: (json['items_used'] as num).toInt(),
      status: json['status'] as String,
      amountPaid: json['amount_paid'] as String,
      plan: SubscriptionPlan.fromJson(json['plan'] as Map<String, dynamic>),
    );

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) =>
    SubscriptionPlan(
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
