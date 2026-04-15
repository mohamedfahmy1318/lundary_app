import 'package:laundry/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_purpose.dart';

class VerificationParams {
  final AuthOtpPurpose purpose;
  final String email;
  final int otpId;
  final int expiresInMinutes;
  final String? message;

  const VerificationParams({
    required this.purpose,
    required this.email,
    required this.otpId,
    required this.expiresInMinutes,
    this.message,
  });

  factory VerificationParams.fromChallenge({
    required AuthOtpPurpose purpose,
    required String email,
    required AuthOtpChallengeEntity challenge,
  }) {
    return VerificationParams(
      purpose: purpose,
      email: email,
      otpId: challenge.otpId,
      expiresInMinutes: challenge.expiresInMinutes,
      message: challenge.message,
    );
  }

  Map<String, String> toQueryParameters() {
    return {
      'purpose': purpose.name,
      'email': email,
      'otpId': otpId.toString(),
      'expiresInMinutes': expiresInMinutes.toString(),
      if (message != null && message!.isNotEmpty) 'message': message!,
    };
  }

  static VerificationParams? fromQueryParameters(Map<String, String> query) {
    final purposeRaw = query['purpose'];
    final email = query['email'];
    final otpIdRaw = query['otpId'];
    final expiresRaw = query['expiresInMinutes'];

    if (purposeRaw == null ||
        email == null ||
        otpIdRaw == null ||
        expiresRaw == null) {
      return null;
    }

    final parsedPurpose = _parsePurpose(purposeRaw);
    final otpId = int.tryParse(otpIdRaw);
    final expiresInMinutes = int.tryParse(expiresRaw);

    if (parsedPurpose == null || otpId == null || expiresInMinutes == null) {
      return null;
    }

    return VerificationParams(
      purpose: parsedPurpose,
      email: email,
      otpId: otpId,
      expiresInMinutes: expiresInMinutes,
      message: query['message'],
    );
  }

  static AuthOtpPurpose? _parsePurpose(String raw) {
    for (final purpose in AuthOtpPurpose.values) {
      if (purpose.name == raw) {
        return purpose;
      }
    }
    return null;
  }
}
