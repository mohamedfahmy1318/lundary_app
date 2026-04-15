import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_purpose.dart';
import 'package:laundry/features/auth/domain/entities/auth_response_entity.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.otpRequested(
    AuthOtpPurpose purpose,
    String email,
    AuthOtpChallengeEntity challenge,
  ) = _OtpRequested;
  const factory AuthState.authenticated(AuthResponseEntity authResponse) =
      _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _Error;
}
