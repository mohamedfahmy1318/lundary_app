abstract class AuthOtpChallengeEntity {
  const AuthOtpChallengeEntity();

  bool get success;
  String get message;
  int get otpId;
  int get expiresInMinutes;
}
