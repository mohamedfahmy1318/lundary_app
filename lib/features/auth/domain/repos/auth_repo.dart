import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:laundry/features/auth/domain/entities/auth_response_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthOtpChallengeEntity>> requestRegisterOtp({
    required String name,
    required String email,
    required String password,
    required String phone,
  });

  Future<Either<Failure, AuthResponseEntity>> verifyRegisterOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, AuthOtpChallengeEntity>> requestLoginOtp({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResponseEntity>> verifyLoginOtp({
    required String email,
    required String otp,
    String fcmToken,
  });

  Future<Either<Failure, AuthResponseEntity>> socialLogin({
    required String firebaseToken,
    String fcmToken,
    required String deviceType,
  });

  Future<Either<Failure, AuthOtpChallengeEntity>> resendOtp({
    required String email,
  });

  Future<Either<Failure, void>> logout();
}
