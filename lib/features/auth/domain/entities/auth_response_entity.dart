import 'package:laundry/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthResponseEntity {
  const AuthResponseEntity();

  String get token;
  AuthUserEntity get user;
}
