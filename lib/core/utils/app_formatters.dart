import 'package:intl/intl.dart';

/// Date and number formatting utilities
///
/// Usage:
///   AppFormatters.formatDate(DateTime.now())           → "Feb 9, 2026"
///   AppFormatters.formatTime(DateTime.now())           → "2:30 PM"
///   AppFormatters.formatDateTime(DateTime.now())       → "Feb 9, 2026 2:30 PM"
///   AppFormatters.timeAgo(DateTime(...))               → "5 minutes ago"
///   AppFormatters.formatPrice(1500.5)                  → "1,500.50"
///   AppFormatters.formatPrice(1500.5, currency: 'EGP') → "1,500.50 EGP"
abstract class AppFormatters {
  // ─── Date ──────────────────────────────────────────────

  static String formatDate(DateTime date, {String pattern = 'MMM d, yyyy'}) {
    return DateFormat(pattern).format(date);
  }

  static String formatTime(DateTime date, {String pattern = 'h:mm a'}) {
    return DateFormat(pattern).format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('MMM d, yyyy h:mm a').format(date);
  }

  /// "5 minutes ago", "2 hours ago", "3 days ago", etc.
  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} minutes ago';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} weeks ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()} months ago';
    return '${(diff.inDays / 365).floor()} years ago';
  }

  /// Parse date string from API (ISO 8601)
  static DateTime? tryParse(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    return DateTime.tryParse(dateString);
  }

  // ─── Numbers ──────────────────────────────────────────

  static String formatPrice(
    double price, {
    String? currency,
    int decimals = 2,
  }) {
    final formatted = NumberFormat.currency(
      decimalDigits: decimals,
      symbol: '',
    ).format(price).trim();
    if (currency != null) return '$formatted $currency';
    return formatted;
  }

  /// 1500 → "1.5K", 1500000 → "1.5M"
  static String formatCompact(num number) {
    return NumberFormat.compact().format(number);
  }

  // ─── Phone ──────────────────────────────────────────

  /// "01012345678" → "010 1234 5678"
  static String formatPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length == 11) {
      return '${cleaned.substring(0, 3)} ${cleaned.substring(3, 7)} ${cleaned.substring(7)}';
    }
    return phone;
  }
}
