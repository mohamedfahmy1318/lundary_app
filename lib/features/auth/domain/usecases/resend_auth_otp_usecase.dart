import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:laundry/features/auth/domain/repos/auth_repo.dart';

class ResendAuthOtpParams extends Equatable {
  final String email;

  const ResendAuthOtpParams({required this.email});

  @override
  List<Object?> get props => [email];
}

class ResendAuthOtpUseCase {
  final AuthRepo _authRepo;

  const ResendAuthOtpUseCase({required AuthRepo authRepo})
    : _authRepo = authRepo;

  Future<Either<Failure, AuthOtpChallengeEntity>> call(
    ResendAuthOtpParams params,
  ) {
    return _authRepo.resendOtp(email: params.email);
  }
}
