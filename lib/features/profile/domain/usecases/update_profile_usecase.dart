import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class UpdateProfileParams extends Equatable {
  final String? name;
  final String? phone;
  final String? avatarFilePath;

  const UpdateProfileParams({this.name, this.phone, this.avatarFilePath});

  @override
  List<Object?> get props => [name, phone, avatarFilePath];
}

class UpdateProfileUseCase {
  final ProfileRepo _profileRepo;

  const UpdateProfileUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, void>> call(UpdateProfileParams params) {
    return _profileRepo.updateProfile(
      name: params.name,
      phone: params.phone,
      avatarFilePath: params.avatarFilePath,
    );
  }
}
