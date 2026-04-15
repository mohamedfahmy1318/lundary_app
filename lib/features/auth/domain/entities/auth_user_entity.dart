abstract class AuthUserEntity {
  const AuthUserEntity();

  int get id;
  String get name;
  String get email;
  String get phone;
  String? get walletBalance;
  String? get avatar;
  String? get role;
}
