import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/profile/domain/entities/active_subscription_entity.dart';
import 'package:laundry/features/profile/domain/entities/subscription_plan_entity.dart';
import 'package:laundry/features/profile/domain/usecases/get_my_subscriptions_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_subscription_plans_usecase.dart';
import 'subscriptions_state.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  final GetSubscriptionPlansUseCase _getSubscriptionPlansUseCase;
  final GetMySubscriptionsUseCase _getMySubscriptionsUseCase;

  SubscriptionsCubit({
    required GetSubscriptionPlansUseCase getSubscriptionPlansUseCase,
    required GetMySubscriptionsUseCase getMySubscriptionsUseCase,
  }) : _getSubscriptionPlansUseCase = getSubscriptionPlansUseCase,
       _getMySubscriptionsUseCase = getMySubscriptionsUseCase,
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
}
