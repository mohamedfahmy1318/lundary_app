import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:laundry/features/auth/domain/entities/auth_response_entity.dart';
import 'package:laundry/features/auth/domain/entities/auth_user_entity.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
abstract class LoginRequestModel with _$LoginRequestModel {
  const factory LoginRequestModel({
    required String email,
    required String password,
  }) = _LoginRequestModel;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
}

@freezed
abstract class RegisterRequestModel with _$RegisterRequestModel {
  const factory RegisterRequestModel({
    required String name,
    required String email,
    required String password,
    required String phone,
    @JsonKey(name: 'password_confirmation')
    required String passwordConfirmation,
  }) = _RegisterRequestModel;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);
}

@freezed
abstract class VerifyOtpRequestModel with _$VerifyOtpRequestModel {
  const factory VerifyOtpRequestModel({
    required String email,
    required String otp,
  }) = _VerifyOtpRequestModel;

  factory VerifyOtpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestModelFromJson(json);
}

@freezed
abstract class LoginVerifyRequestModel with _$LoginVerifyRequestModel {
  const factory LoginVerifyRequestModel({
    required String email,
    required String otp,
    @JsonKey(name: 'fcm_token') @Default('') String fcmToken,
  }) = _LoginVerifyRequestModel;

  factory LoginVerifyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginVerifyRequestModelFromJson(json);
}

@freezed
abstract class SocialLoginRequestModel with _$SocialLoginRequestModel {
  const factory SocialLoginRequestModel({
    @JsonKey(name: 'firebase_token') required String firebaseToken,
    @JsonKey(name: 'fcm_token') @Default('') String fcmToken,
    @JsonKey(name: 'device_type') required String deviceType,
  }) = _SocialLoginRequestModel;

  factory SocialLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginRequestModelFromJson(json);
}

@freezed
abstract class ResendOtpRequestModel with _$ResendOtpRequestModel {
  const factory ResendOtpRequestModel({required String email}) =
      _ResendOtpRequestModel;

  factory ResendOtpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResendOtpRequestModelFromJson(json);
}

@freezed
abstract class OtpChallengeModel extends AuthOtpChallengeEntity
    with _$OtpChallengeModel {
  const OtpChallengeModel._();

  const factory OtpChallengeModel({
    required bool success,
    required String message,
    @JsonKey(name: 'otp_id') required int otpId,
    @JsonKey(name: 'expires_in_minutes') required int expiresInMinutes,
  }) = _OtpChallengeModel;

  factory OtpChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$OtpChallengeModelFromJson(json);
}

@freezed
abstract class AuthResponseModel extends AuthResponseEntity
    with _$AuthResponseModel {
  const AuthResponseModel._();

  const factory AuthResponseModel({
    required String token,
    required UserModel user,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}

@freezed
abstract class UserModel extends AuthUserEntity with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required int id,
    required String name,
    required String email,
    @JsonKey(fromJson: UserModel._stringOrEmptyFromJson) required String phone,
    @JsonKey(
      name: 'wallet_balance',
      fromJson: UserModel._walletBalanceFromJson,
      toJson: UserModel._walletBalanceToJson,
    )
    String? walletBalance,
    String? avatar,
    String? role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  static String _stringOrEmptyFromJson(Object? value) =>
      value?.toString() ?? '';

  static String? _walletBalanceFromJson(Object? value) => value?.toString();
  static Object? _walletBalanceToJson(String? value) => value;
}
