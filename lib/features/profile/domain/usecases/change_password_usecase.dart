import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class ChangePasswordParams extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordParams({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword, confirmPassword];
}

class ChangePasswordUseCase {
  final ProfileRepo _profileRepo;

  const ChangePasswordUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, void>> call(ChangePasswordParams params) {
    return _profileRepo.changePassword(
      currentPassword: params.currentPassword,
      newPassword: params.newPassword,
      confirmPassword: params.confirmPassword,
    );
  }
}
