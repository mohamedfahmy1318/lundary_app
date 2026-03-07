import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable()
class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String passwordConfirmation;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthResponseModel {
  final String token;
  final UserModel user;

  AuthResponseModel({required this.token, required this.user});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? walletBalance;
  final String? avatar;
  final String? role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.walletBalance,
    this.avatar,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
