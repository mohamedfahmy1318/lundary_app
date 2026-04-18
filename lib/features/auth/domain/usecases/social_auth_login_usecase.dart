import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/auth/domain/entities/auth_response_entity.dart';
import 'package:laundry/features/auth/domain/repos/auth_repo.dart';

class SocialAuthLoginParams extends Equatable {
  final String firebaseToken;
  final String fcmToken;
  final String deviceType;

  const SocialAuthLoginParams({
    required this.firebaseToken,
    this.fcmToken = '',
    required this.deviceType,
  });

  @override
  List<Object?> get props => [firebaseToken, fcmToken, deviceType];
}

class SocialAuthLoginUseCase {
  final AuthRepo _authRepo;

  const SocialAuthLoginUseCase({required AuthRepo authRepo})
    : _authRepo = authRepo;

  Future<Either<Failure, AuthResponseEntity>> call(
    SocialAuthLoginParams params,
  ) {
    return _authRepo.socialLogin(
      firebaseToken: params.firebaseToken,
      fcmToken: params.fcmToken,
      deviceType: params.deviceType,
    );
  }
}
