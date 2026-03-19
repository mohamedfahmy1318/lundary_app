import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/profile/data/models/profile_model.dart';

part 'subscriptions_state.freezed.dart';

@freezed
class SubscriptionsState with _$SubscriptionsState {
  const factory SubscriptionsState.initial() = _Initial;
  const factory SubscriptionsState.loading() = _Loading;
  const factory SubscriptionsState.loaded({
    required List<SubscriptionPlan> plans,
    required List<ActiveSubscription> mySubscriptions,
  }) = _Loaded;
  const factory SubscriptionsState.error(String message) = _Error;
}
