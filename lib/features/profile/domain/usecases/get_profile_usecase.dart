import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/entities/profile_entity.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class GetProfileUseCase {
  final ProfileRepo _profileRepo;

  const GetProfileUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, ProfileEntity>> call() {
    return _profileRepo.getProfile();
  }
}
