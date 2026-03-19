import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';
import 'package:laundry/features/profile/presentation/cubit/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ProfileRepo _repo;

  ChangePasswordCubit(this._repo) : super(const ChangePasswordState.initial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword != confirmPassword) {
      emit(const ChangePasswordState.error("Passwords do not match"));
      return;
    }

    emit(const ChangePasswordState.loading());
    
    final result = await _repo.changePassword({
      'current_password': currentPassword,
      'password': newPassword,
      'password_confirmation': confirmPassword,
    });

    result.fold(
      (failure) => emit(ChangePasswordState.error(failure.message)),
      (_) => emit(const ChangePasswordState.success("Password changed successfully")),
    );
  }
}
