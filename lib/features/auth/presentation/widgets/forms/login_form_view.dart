import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/widgets/custom_button.dart';
import 'package:laundry/features/auth/presentation/widgets/auth_header.dart';
import 'package:laundry/features/auth/presentation/widgets/forms/auth_form_scaffold.dart';
import 'package:laundry/features/auth/presentation/widgets/forms/auth_input_fields.dart';
import 'package:laundry/features/auth/presentation/widgets/have_account_row.dart';
import 'package:laundry/features/auth/presentation/widgets/or_divider.dart';
import 'package:laundry/features/auth/presentation/widgets/social_login_row.dart';

class LoginFormView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordObscured;
  final bool isLoading;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onSubmit;
  final VoidCallback onNavigateToRegister;

  const LoginFormView({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordObscured,
    required this.isLoading,
    required this.onTogglePasswordVisibility,
    required this.onSubmit,
    required this.onNavigateToRegister,
  });

  @override
  Widget build(BuildContext context) {
    return AuthFormScaffold(
      formKey: formKey,
      children: [
        SizedBox(height: 60.h),
        const AuthHeader(
          title: 'Welcome Back',
          subtitle:
              'Cleaning Service is here to keep your home, office, or apartment clean with trusted and professional cleaners.',
        ),
        SizedBox(height: 60.h),
        AuthEmailField(
          controller: emailController,
          hintText: 'Enter your email address..',
          iconData: Icons.email,
          iconColor: const Color(0xffb6b6b7),
        ),
        SizedBox(height: 10.h),
        AuthPasswordField(
          controller: passwordController,
          hintText: 'Set your preferred password..',
          obscureText: isPasswordObscured,
          onToggleVisibility: onTogglePasswordVisibility,
          leadingIcon: Icons.lock,
          iconColor: const Color(0xffb6b6b7),
        ),
        SizedBox(height: 32.h),
        CustomButton(
          text: 'Sign In',
          isLoading: isLoading,
          onPressed: () {
            if (formKey.currentState?.validate() ?? false) {
              onSubmit();
            }
          },
        ),
        SizedBox(height: 32.h),
        const OrDivider(text: 'Or sign in with'),
        SizedBox(height: 24.h),
        const SocialLoginRow(),
        SizedBox(height: 120.h),
        AuthAccountPromptRow(
          text: "Don't have an account?",
          buttonText: 'Sign up now!',
          onPressed: onNavigateToRegister,
        ),
      ],
    );
  }
}
