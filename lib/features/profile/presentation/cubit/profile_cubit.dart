import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/logout_profile_usecase.dart';
import 'package:laundry/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final LogoutProfileUseCase _logoutProfileUseCase;

  ProfileCubit({
    required GetProfileUseCase getProfileUseCase,
    required DeleteAccountUseCase deleteAccountUseCase,
    required LogoutProfileUseCase logoutProfileUseCase,
  }) : _getProfileUseCase = getProfileUseCase,
       _deleteAccountUseCase = deleteAccountUseCase,
       _logoutProfileUseCase = logoutProfileUseCase,
       super(const ProfileState.initial());

  Future<void> loadProfile() async {
    emit(const ProfileState.loading());

    final profileResult = await _getProfileUseCase();

    profileResult.fold((failure) => emit(ProfileState.error(failure.message)), (
      profile,
    ) {
      emit(ProfileState.loaded(profile: profile));
    });
  }

  Future<void> deleteAccount() async {
    final result = await _deleteAccountUseCase();
    result.fold((failure) => emit(ProfileState.error(failure.message)), (_) {
      // Handle post-deletion (navigate to login, clear cache, etc.)
    });
  }

  Future<void> logout() async {
    final result = await _logoutProfileUseCase();
    result.fold((failure) => emit(ProfileState.error(failure.message)), (_) {
      // Handle post-logout (navigate to login, clear cache, etc.)
    });
  }
}
