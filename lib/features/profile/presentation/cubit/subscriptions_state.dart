import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/profile/domain/entities/active_subscription_entity.dart';
import 'package:laundry/features/profile/domain/entities/subscription_plan_entity.dart';

part 'subscriptions_state.freezed.dart';

@freezed
class SubscriptionsState with _$SubscriptionsState {
  const factory SubscriptionsState.initial() = _Initial;
  const factory SubscriptionsState.loading() = _Loading;
  const factory SubscriptionsState.loaded({
    required List<SubscriptionPlanEntity> plans,
    required List<ActiveSubscriptionEntity> mySubscriptions,
  }) = _Loaded;
  const factory SubscriptionsState.error(String message) = _Error;
}
