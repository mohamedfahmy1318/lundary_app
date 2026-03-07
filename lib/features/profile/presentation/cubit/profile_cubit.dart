import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';
import 'package:laundry/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _repo;

  ProfileCubit({required ProfileRepo repo})
    : _repo = repo,
      super(const ProfileState.initial());

  Future<void> loadProfile() async {
    emit(const ProfileState.loading());

    final profileResult = await _repo.getProfile();
    final ticketsResult = await _repo.getTickets();
    final plansResult = await _repo.getSubscriptionPlans();

    if (profileResult.isLeft()) {
      profileResult.fold(
        (failure) => emit(ProfileState.error(failure.message)),
        (_) {},
      );
      return;
    }

    emit(
      ProfileState.loaded(
        profile: profileResult.getOrElse(() => {}),
        tickets: ticketsResult.getOrElse(() => []),
        subscriptionPlans: plansResult.getOrElse(() => []),
      ),
    );
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final result = await _repo.updateProfile(data);
    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (_) => loadProfile(),
    );
  }

  Future<void> createTicket(Map<String, dynamic> ticketData) async {
    final result = await _repo.createTicket(ticketData);
    result.fold(
      (failure) => emit(ProfileState.error(failure.message)),
      (_) => loadProfile(),
    );
  }

  Future<void> deleteAccount() async {
    final result = await _repo.deleteAccount();
    result.fold((failure) => emit(ProfileState.error(failure.message)), (_) {
      // Handle post-deletion (navigate to login, clear cache, etc.)
    });
  }

  Future<void> logout() async {
    final result = await _repo.logout();
    result.fold((failure) => emit(ProfileState.error(failure.message)), (_) {
      // Handle post-logout (navigate to login, clear cache, etc.)
    });
  }
}
