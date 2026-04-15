import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_purpose.dart';
import 'package:laundry/features/auth/domain/entities/auth_response_entity.dart';
import 'package:laundry/features/auth/domain/repos/auth_repo.dart';

class VerifyAuthOtpParams extends Equatable {
  final AuthOtpPurpose purpose;
  final String email;
  final String otp;
  final String fcmToken;

  const VerifyAuthOtpParams({
    required this.purpose,
    required this.email,
    required this.otp,
    this.fcmToken = '',
  });

  @override
  List<Object?> get props => [purpose, email, otp, fcmToken];
}

class VerifyAuthOtpUseCase {
  final AuthRepo _authRepo;

  const VerifyAuthOtpUseCase({required AuthRepo authRepo})
    : _authRepo = authRepo;

  Future<Either<Failure, AuthResponseEntity>> call(VerifyAuthOtpParams params) {
    return switch (params.purpose) {
      AuthOtpPurpose.register => _authRepo.verifyRegisterOtp(
        email: params.email,
        otp: params.otp,
      ),
      AuthOtpPurpose.login => _authRepo.verifyLoginOtp(
        email: params.email,
        otp: params.otp,
        fcmToken: params.fcmToken,
      ),
    };
  }
}
