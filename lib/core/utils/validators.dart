import 'package:laundry/core/constants/app_strings.dart';

abstract class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    if (!RegExp(
      r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$',
    ).hasMatch(value)) {
      return AppStrings.invalidPhone;
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    if (value.length < 6) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? minLength(String? value, int min) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    if (value.length < min) {
      return 'Must be at least $min characters';
    }
    return null;
  }
}
