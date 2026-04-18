import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:laundry/features/profile/domain/entities/subscription_checkout_entity.dart';
import 'package:laundry/features/profile/domain/entities/active_subscription_entity.dart';
import 'package:laundry/features/profile/domain/entities/subscription_plan_entity.dart';
import 'package:laundry/features/profile/domain/usecases/get_my_subscriptions_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_subscription_plans_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/subscribe_to_plan_usecase.dart';
import 'subscriptions_state.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  final GetSubscriptionPlansUseCase _getSubscriptionPlansUseCase;
  final GetMySubscriptionsUseCase _getMySubscriptionsUseCase;
  final SubscribeToPlanUseCase _subscribeToPlanUseCase;

  SubscriptionsCubit({
    required GetSubscriptionPlansUseCase getSubscriptionPlansUseCase,
    required GetMySubscriptionsUseCase getMySubscriptionsUseCase,
    required SubscribeToPlanUseCase subscribeToPlanUseCase,
  }) : _getSubscriptionPlansUseCase = getSubscriptionPlansUseCase,
       _getMySubscriptionsUseCase = getMySubscriptionsUseCase,
       _subscribeToPlanUseCase = subscribeToPlanUseCase,
       super(const SubscriptionsState.initial());

  Future<void> loadSubscriptions() async {
    emit(const SubscriptionsState.loading());

    final plansResult = await _getSubscriptionPlansUseCase();
    final mySubsResult = await _getMySubscriptionsUseCase();

    // Since we fetch them together, if one completely fails with network issues, it fails all.
    // We can handle both fold results concurrently.
    String? errorMessage;
    List<SubscriptionPlanEntity>? plans;
    List<ActiveSubscriptionEntity>? mySubscriptions;

    plansResult.fold(
      (failure) => errorMessage = failure.message,
      (data) => plans = data,
    );

    mySubsResult.fold(
      (failure) => errorMessage ??= failure.message,
      (data) => mySubscriptions = data,
    );

    if (errorMessage != null) {
      emit(SubscriptionsState.error(errorMessage!));
    } else {
      emit(
        SubscriptionsState.loaded(
          plans: plans ?? [],
          mySubscriptions: mySubscriptions ?? [],
        ),
      );
    }
  }

  Future<Either<String, SubscriptionCheckoutEntity>> subscribeToPlan(
    int planId,
  ) async {
    final result = await _subscribeToPlanUseCase(
      SubscribeToPlanParams(planId: planId),
    );

    return result.fold(
      (failure) => Left(failure.message),
      (checkout) => Right(checkout),
    );
  }

  Future<bool> waitUntilPlanIsActive({
    required int planId,
    int maxAttempts = 8,
    Duration interval = const Duration(seconds: 2),
  }) async {
    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final mySubsResult = await _getMySubscriptionsUseCase();
      final isActive = mySubsResult.fold((_) => false, (subscriptions) {
        return subscriptions.any(
          (sub) =>
              sub.planId == planId &&
              sub.status.trim().toLowerCase() == 'active',
        );
      });

      if (isActive) {
        return true;
      }

      if (attempt < maxAttempts - 1) {
        await Future<void>.delayed(interval);
      }
    }

    return false;
  }
}
