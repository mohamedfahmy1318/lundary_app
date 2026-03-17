// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$LoginRequestModelToJson(LoginRequestModel instance) =>
    <String, dynamic>{'email': instance.email, 'password': instance.password};

Map<String, dynamic> _$RegisterRequestModelToJson(
  RegisterRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
  'phone': instance.phone,
  'password_confirmation': instance.passwordConfirmation,
};

AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    AuthResponseModel(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  walletBalance: json['wallet_balance'] as String?,
  avatar: json['avatar'] as String?,
  role: json['role'] as String?,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'wallet_balance': instance.walletBalance,
  'avatar': instance.avatar,
  'role': instance.role,
};
