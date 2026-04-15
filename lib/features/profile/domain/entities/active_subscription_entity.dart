import 'package:laundry/features/profile/domain/entities/subscription_plan_entity.dart';

abstract class ActiveSubscriptionEntity {
  const ActiveSubscriptionEntity();

  int get id;
  int get userId;
  int get planId;
  String get startsAt;
  String get endsAt;
  int get itemsUsed;
  String get status;
  String get amountPaid;
  SubscriptionPlanEntity get plan;
}
