/// Common regex patterns used across the app
///
/// Usage:
///   if (AppRegex.email.hasMatch(value)) { ... }
///   inputFormatters: [FilteringTextInputFormatter.allow(AppRegex.digitsOnly)]
abstract class AppRegex {
  /// Email validation
  static final RegExp email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Phone (Egyptian format): 01xxxxxxxxx
  static final RegExp egyptPhone = RegExp(r'^01[0125][0-9]{8}$');

  /// International phone
  static final RegExp phone = RegExp(
    r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
  );

  /// Only digits
  static final RegExp digitsOnly = RegExp(r'[0-9]');

  /// Only letters (English + Arabic)
  static final RegExp lettersOnly = RegExp(r'[a-zA-Z\u0600-\u06FF\s]');

  /// Alphanumeric
  static final RegExp alphanumeric = RegExp(r'[a-zA-Z0-9]');

  /// Password: at least 1 uppercase, 1 lowercase, 1 digit, min 8 chars
  static final RegExp strongPassword = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$',
  );

  /// URL
  static final RegExp url = RegExp(
    r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)',
  );

  /// Arabic text only
  static final RegExp arabicOnly = RegExp(r'^[\u0600-\u06FF\s]+$');

  /// English text only
  static final RegExp englishOnly = RegExp(r'^[a-zA-Z\s]+$');
}
