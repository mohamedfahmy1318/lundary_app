// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    _LoginRequestModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginRequestModelToJson(_LoginRequestModel instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

_RegisterRequestModel _$RegisterRequestModelFromJson(
  Map<String, dynamic> json,
) => _RegisterRequestModel(
  name: json['name'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
  phone: json['phone'] as String,
  passwordConfirmation: json['password_confirmation'] as String,
);

Map<String, dynamic> _$RegisterRequestModelToJson(
  _RegisterRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
  'phone': instance.phone,
  'password_confirmation': instance.passwordConfirmation,
};

_VerifyOtpRequestModel _$VerifyOtpRequestModelFromJson(
  Map<String, dynamic> json,
) => _VerifyOtpRequestModel(
  email: json['email'] as String,
  otp: json['otp'] as String,
);

Map<String, dynamic> _$VerifyOtpRequestModelToJson(
  _VerifyOtpRequestModel instance,
) => <String, dynamic>{'email': instance.email, 'otp': instance.otp};

_LoginVerifyRequestModel _$LoginVerifyRequestModelFromJson(
  Map<String, dynamic> json,
) => _LoginVerifyRequestModel(
  email: json['email'] as String,
  otp: json['otp'] as String,
  fcmToken: json['fcm_token'] as String? ?? '',
);

Map<String, dynamic> _$LoginVerifyRequestModelToJson(
  _LoginVerifyRequestModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'otp': instance.otp,
  'fcm_token': instance.fcmToken,
};

_ResendOtpRequestModel _$ResendOtpRequestModelFromJson(
  Map<String, dynamic> json,
) => _ResendOtpRequestModel(email: json['email'] as String);

Map<String, dynamic> _$ResendOtpRequestModelToJson(
  _ResendOtpRequestModel instance,
) => <String, dynamic>{'email': instance.email};

_OtpChallengeModel _$OtpChallengeModelFromJson(Map<String, dynamic> json) =>
    _OtpChallengeModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      otpId: (json['otp_id'] as num).toInt(),
      expiresInMinutes: (json['expires_in_minutes'] as num).toInt(),
    );

Map<String, dynamic> _$OtpChallengeModelToJson(_OtpChallengeModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otp_id': instance.otpId,
      'expires_in_minutes': instance.expiresInMinutes,
    };

_AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    _AuthResponseModel(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseModelToJson(_AuthResponseModel instance) =>
    <String, dynamic>{'token': instance.token, 'user': instance.user};

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  walletBalance: UserModel._walletBalanceFromJson(json['wallet_balance']),
  avatar: json['avatar'] as String?,
  role: json['role'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'wallet_balance': UserModel._walletBalanceToJson(instance.walletBalance),
      'avatar': instance.avatar,
      'role': instance.role,
    };
