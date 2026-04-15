import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/widgets/custom_button.dart';
import 'package:laundry/features/auth/presentation/widgets/auth_header.dart';
import 'package:laundry/features/auth/presentation/widgets/forms/auth_form_scaffold.dart';
import 'package:laundry/features/auth/presentation/widgets/forms/auth_input_fields.dart';
import 'package:laundry/features/auth/presentation/widgets/have_account_row.dart';
import 'package:laundry/features/auth/presentation/widgets/or_divider.dart';
import 'package:laundry/features/auth/presentation/widgets/social_login_row.dart';

class RegisterFormView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;
  final bool isLoading;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onToggleConfirmPasswordVisibility;
  final VoidCallback onSubmit;
  final VoidCallback onNavigateToLogin;

  const RegisterFormView({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.isPasswordObscured,
    required this.isConfirmPasswordObscured,
    required this.isLoading,
    required this.onTogglePasswordVisibility,
    required this.onToggleConfirmPasswordVisibility,
    required this.onSubmit,
    required this.onNavigateToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return AuthFormScaffold(
      formKey: formKey,
      children: [
        SizedBox(height: 40.h),
        const AuthHeader(
          title: 'A cleaner space\nstarts here!',
          subtitle:
              'Cleaning Service is here to keep your home, office, or apartment clean with trusted and professional cleaners.',
        ),
        SizedBox(height: 30.h),
        AuthUsernameField(
          controller: usernameController,
          hintText: 'Set your username',
        ),
        SizedBox(height: 16.h),
        AuthEmailField(
          controller: emailController,
          hintText: 'Enter your email address..',
        ),
        SizedBox(height: 16.h),
        AuthPasswordField(
          controller: passwordController,
          hintText: 'Set your preferred password..',
          obscureText: isPasswordObscured,
          onToggleVisibility: onTogglePasswordVisibility,
        ),
        SizedBox(height: 16.h),
        AuthConfirmPasswordField(
          controller: confirmPasswordController,
          passwordController: passwordController,
          hintText: 'Confirm your password..',
          obscureText: isConfirmPasswordObscured,
          onToggleVisibility: onToggleConfirmPasswordVisibility,
        ),
        SizedBox(height: 16.h),
        AuthPhoneField(
          controller: phoneController,
          hintText: 'Enter your mobile number..',
        ),
        SizedBox(height: 32.h),
        CustomButton(
          text: 'Create Account',
          isLoading: isLoading,
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              onSubmit();
            }
          },
        ),
        SizedBox(height: 32.h),
        const OrDivider(text: 'Or sign up with'),
        SizedBox(height: 24.h),
        const SocialLoginRow(),
        SizedBox(height: 40.h),
        AuthAccountPromptRow(
          text: 'Need premium laundry services?',
          buttonText: 'Sign in now!',
          onPressed: onNavigateToLogin,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
