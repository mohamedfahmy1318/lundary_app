import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/profile/domain/usecases/update_profile_usecase.dart';
import 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileUseCase _updateProfileUseCase;

  UpdateProfileCubit({required UpdateProfileUseCase updateProfileUseCase})
    : _updateProfileUseCase = updateProfileUseCase,
      super(const UpdateProfileState.initial());

  Future<void> updateProfile({
    String? name,
    String? phone,
    String? avatarFilePath,
    List<String>? addresses,
  }) async {
    if (name == null &&
        phone == null &&
        avatarFilePath == null &&
        addresses == null) {
      return;
    }

    emit(const UpdateProfileState.loading());
    final result = await _updateProfileUseCase(
      UpdateProfileParams(
        name: name,
        phone: phone,
        avatarFilePath: avatarFilePath,
        addresses: addresses,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(UpdateProfileState.error(failure.message)),
      (_) => emit(
        const UpdateProfileState.success('Profile updated successfully!'),
      ),
    );
  }
}
