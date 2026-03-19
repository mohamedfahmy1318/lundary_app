import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? walletBalance;
  final String? avatar;
  final ActiveSubscription? activeSubscription;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.walletBalance,
    this.avatar,
    this.activeSubscription,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  String? get fullAvatarUrl {
    if (avatar == null || avatar!.isEmpty) return null;
    if (avatar!.startsWith('http')) return avatar;
    return 'https://laundry.findosystem.com/storage/$avatar';
  }
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class ActiveSubscription {
  final int id;
  final int userId;
  final int planId;
  final String startsAt;
  final String endsAt;
  final int itemsUsed;
  final String status;
  final String amountPaid;
  final SubscriptionPlan plan;

  ActiveSubscription({
    required this.id,
    required this.userId,
    required this.planId,
    required this.startsAt,
    required this.endsAt,
    required this.itemsUsed,
    required this.status,
    required this.amountPaid,
    required this.plan,
  });

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) =>
      _$ActiveSubscriptionFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class SubscriptionPlan {
  final int id;
  final String name;
  final String slug;
  final String? description;
  final String price;
  final int durationDays;
  final int itemLimit;
  final bool unlimitedItems;
  final bool freeDelivery;
  final bool expressService;
  final bool prioritySupport;
  final int discountPercentage;
  final bool isActive;

  SubscriptionPlan({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    required this.price,
    required this.durationDays,
    required this.itemLimit,
    required this.unlimitedItems,
    required this.freeDelivery,
    required this.expressService,
    required this.prioritySupport,
    required this.discountPercentage,
    required this.isActive,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanFromJson(json);
}
