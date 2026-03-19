import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/profile/data/models/profile_model.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';
import 'subscriptions_state.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  final ProfileRepo _repo;

  SubscriptionsCubit({required ProfileRepo repo})
    : _repo = repo,
      super(const SubscriptionsState.initial());

  Future<void> loadSubscriptions() async {
    emit(const SubscriptionsState.loading());

    final plansResult = await _repo.getSubscriptionPlans();
    final mySubsResult = await _repo.getMySubscriptions();

    // Since we fetch them together, if one completely fails with network issues, it fails all.
    // We can handle both fold results concurrently.
    String? errorMessage;
    List<SubscriptionPlan>? plans;
    List<ActiveSubscription>? mySubscriptions;

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
