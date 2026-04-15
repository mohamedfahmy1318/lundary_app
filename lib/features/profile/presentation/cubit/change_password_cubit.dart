import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:laundry/features/profile/presentation/cubit/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit({required ChangePasswordUseCase changePasswordUseCase})
    : _changePasswordUseCase = changePasswordUseCase,
      super(const ChangePasswordState.initial());

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

    final result = await _changePasswordUseCase(
      ChangePasswordParams(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      ),
    );

    result.fold(
      (failure) => emit(ChangePasswordState.error(failure.message)),
      (_) => emit(
        const ChangePasswordState.success('Password changed successfully'),
      ),
    );
  }
}
