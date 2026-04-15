import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:laundry/features/auth/domain/repos/auth_repo.dart';

class RequestRegisterOtpParams extends Equatable {
  final String name;
  final String email;
  final String password;
  final String phone;

  const RequestRegisterOtpParams({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  @override
  List<Object?> get props => [name, email, password, phone];
}

class RequestRegisterOtpUseCase {
  final AuthRepo _authRepo;

  const RequestRegisterOtpUseCase({required AuthRepo authRepo})
    : _authRepo = authRepo;

  Future<Either<Failure, AuthOtpChallengeEntity>> call(
    RequestRegisterOtpParams params,
  ) {
    return _authRepo.requestRegisterOtp(
      name: params.name,
      email: params.email,
      password: params.password,
      phone: params.phone,
    );
  }
}
