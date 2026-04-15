import 'package:flutter/material.dart';
import 'package:laundry/core/utils/validators.dart';
import 'package:laundry/core/widgets/custom_text_field.dart';

class AuthUsernameField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AuthUsernameField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
      validator: Validators.required,
    );
  }
}

class AuthEmailField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData iconData;
  final Color iconColor;

  const AuthEmailField({
    super.key,
    required this.controller,
    required this.hintText,
    this.iconData = Icons.email_outlined,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      prefixIcon: Icon(iconData, color: iconColor),
      keyboardType: TextInputType.emailAddress,
      validator: Validators.email,
    );
  }
}

class AuthPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const AuthPhoneField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      prefixIcon: const Icon(Icons.phone_android, color: Colors.grey),
      keyboardType: TextInputType.phone,
      validator: Validators.phone,
    );
  }
}

class AuthPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final IconData leadingIcon;
  final Color iconColor;
  final String? Function(String?)? validator;

  const AuthPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.onToggleVisibility,
    this.leadingIcon = Icons.lock_outline,
    this.iconColor = Colors.grey,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      prefixIcon: Icon(leadingIcon, color: iconColor),
      obscureText: obscureText,
      suffixIcon: IconButton(
        onPressed: onToggleVisibility,
        icon: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
          color: iconColor,
        ),
      ),
      validator: validator ?? Validators.password,
    );
  }
}

class AuthConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;
  final IconData leadingIcon;
  final Color iconColor;

  const AuthConfirmPasswordField({
    super.key,
    required this.controller,
    required this.passwordController,
    required this.hintText,
    required this.obscureText,
    required this.onToggleVisibility,
    this.leadingIcon = Icons.lock_outline,
    this.iconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      prefixIcon: Icon(leadingIcon, color: iconColor),
      obscureText: obscureText,
      suffixIcon: IconButton(
        onPressed: onToggleVisibility,
        icon: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
          color: iconColor,
        ),
      ),
      validator:
          (value) => Validators.confirmPassword(value, passwordController.text),
    );
  }
}
