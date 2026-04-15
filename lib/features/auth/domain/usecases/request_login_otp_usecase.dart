import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:laundry/features/auth/domain/repos/auth_repo.dart';

class RequestLoginOtpParams extends Equatable {
  final String email;
  final String password;

  const RequestLoginOtpParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RequestLoginOtpUseCase {
  final AuthRepo _authRepo;

  const RequestLoginOtpUseCase({required AuthRepo authRepo})
    : _authRepo = authRepo;

  Future<Either<Failure, AuthOtpChallengeEntity>> call(
    RequestLoginOtpParams params,
  ) {
    return _authRepo.requestLoginOtp(
      email: params.email,
      password: params.password,
    );
  }
}
