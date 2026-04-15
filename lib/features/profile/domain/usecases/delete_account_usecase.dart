import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class DeleteAccountUseCase {
  final ProfileRepo _profileRepo;

  const DeleteAccountUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, void>> call() {
    return _profileRepo.deleteAccount();
  }
}
