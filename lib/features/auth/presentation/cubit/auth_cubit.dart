import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_purpose.dart';
import 'package:laundry/features/auth/domain/entities/auth_response_entity.dart';
import 'package:laundry/features/auth/domain/usecases/logout_auth_usecase.dart';
import 'package:laundry/features/auth/domain/usecases/request_login_otp_usecase.dart';
import 'package:laundry/features/auth/domain/usecases/request_register_otp_usecase.dart';
import 'package:laundry/features/auth/domain/usecases/resend_auth_otp_usecase.dart';
import 'package:laundry/features/auth/domain/usecases/verify_auth_otp_usecase.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final RequestLoginOtpUseCase _requestLoginOtpUseCase;
  final RequestRegisterOtpUseCase _requestRegisterOtpUseCase;
  final VerifyAuthOtpUseCase _verifyAuthOtpUseCase;
  final ResendAuthOtpUseCase _resendAuthOtpUseCase;
  final LogoutAuthUseCase _logoutAuthUseCase;

  AuthCubit({
    required RequestLoginOtpUseCase requestLoginOtpUseCase,
    required RequestRegisterOtpUseCase requestRegisterOtpUseCase,
    required VerifyAuthOtpUseCase verifyAuthOtpUseCase,
    required ResendAuthOtpUseCase resendAuthOtpUseCase,
    required LogoutAuthUseCase logoutAuthUseCase,
  }) : _requestLoginOtpUseCase = requestLoginOtpUseCase,
       _requestRegisterOtpUseCase = requestRegisterOtpUseCase,
       _verifyAuthOtpUseCase = verifyAuthOtpUseCase,
       _resendAuthOtpUseCase = resendAuthOtpUseCase,
       _logoutAuthUseCase = logoutAuthUseCase,
       super(const AuthState.initial());

  Future<void> requestLoginOtp(String email, String password) async {
    final trimmedEmail = email.trim();
    final trimmedPassword = password.trim();
    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      emit(const AuthState.error('Email and password are required.'));
      return;
    }

    await _runOtpChallengeRequest(
      purpose: AuthOtpPurpose.login,
      email: trimmedEmail,
      request:
          () => _requestLoginOtpUseCase(
            RequestLoginOtpParams(
              email: trimmedEmail,
              password: trimmedPassword,
            ),
          ),
    );
  }

  Future<void> requestRegisterOtp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    final trimmedName = name.trim();
    final trimmedEmail = email.trim();
    final trimmedPassword = password.trim();
    final trimmedPhone = phone.trim();

    if (trimmedName.isEmpty ||
        trimmedEmail.isEmpty ||
        trimmedPassword.isEmpty ||
        trimmedPhone.isEmpty) {
      emit(const AuthState.error('All registration fields are required.'));
      return;
    }

    await _runOtpChallengeRequest(
      purpose: AuthOtpPurpose.register,
      email: trimmedEmail,
      request:
          () => _requestRegisterOtpUseCase(
            RequestRegisterOtpParams(
              name: trimmedName,
              email: trimmedEmail,
              password: trimmedPassword,
              phone: trimmedPhone,
            ),
          ),
    );
  }

  Future<void> verifyOtp({
    required AuthOtpPurpose purpose,
    required String email,
    required String otp,
    String fcmToken = '',
  }) async {
    final trimmedEmail = email.trim();
    final trimmedOtp = otp.trim();

    if (trimmedEmail.isEmpty) {
      emit(const AuthState.error('Email is required.'));
      return;
    }

    if (trimmedOtp.length != 5) {
      emit(const AuthState.error('Please enter a valid 5-digit code.'));
      return;
    }

    await _runAuthResponseRequest(
      request:
          () => _verifyAuthOtpUseCase(
            VerifyAuthOtpParams(
              purpose: purpose,
              email: trimmedEmail,
              otp: trimmedOtp,
              fcmToken: fcmToken,
            ),
          ),
    );
  }

  Future<void> resendOtp({
    required String email,
    required AuthOtpPurpose purpose,
  }) async {
    final trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty) {
      emit(const AuthState.error('Email is required to resend the code.'));
      return;
    }

    await _runOtpChallengeRequest(
      purpose: purpose,
      email: trimmedEmail,
      request:
          () => _resendAuthOtpUseCase(ResendAuthOtpParams(email: trimmedEmail)),
    );
  }

  Future<void> logout() async {
    emit(const AuthState.loading());

    final result = await _logoutAuthUseCase();
    _emitResult<void>(
      result: result,
      onSuccess: (_) => emit(const AuthState.unauthenticated()),
    );
  }

  Future<void> _runOtpChallengeRequest({
    required AuthOtpPurpose purpose,
    required String email,
    required Future<Either<Failure, AuthOtpChallengeEntity>> Function() request,
  }) async {
    emit(const AuthState.loading());

    final result = await request();
    _emitResult<AuthOtpChallengeEntity>(
      result: result,
      onSuccess:
          (challenge) =>
              emit(AuthState.otpRequested(purpose, email, challenge)),
    );
  }

  Future<void> _runAuthResponseRequest({
    required Future<Either<Failure, AuthResponseEntity>> Function() request,
  }) async {
    emit(const AuthState.loading());

    final result = await request();
    _emitResult<AuthResponseEntity>(
      result: result,
      onSuccess: (response) => emit(AuthState.authenticated(response)),
    );
  }

  void _emitResult<T>({
    required Either<Failure, T> result,
    required void Function(T value) onSuccess,
  }) {
    result.fold((failure) => emit(AuthState.error(failure.message)), onSuccess);
  }
}
