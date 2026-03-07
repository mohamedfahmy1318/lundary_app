import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/core/utils/validators.dart';
import 'package:laundry/core/widgets/app_dialogs.dart';
import 'package:laundry/core/widgets/custom_button.dart';
import 'package:laundry/core/widgets/custom_text_field.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_state.dart';
import 'package:laundry/features/auth/presentation/widgets/auth_header.dart';
import 'package:laundry/features/auth/presentation/widgets/or_divider.dart';
import 'package:laundry/features/auth/presentation/widgets/social_login_row.dart';
import 'package:laundry/features/auth/presentation/widgets/have_account_row.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              state.maybeWhen(
                authenticated: (response) {
                  context.goNamed('main');
                },
                error: (message) {
                  AppDialogs.showMessage(
                    isError: true,
                    message: message,
                    title: 'Error',
                    context,
                  );
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),
                      const AuthHeader(
                        title: 'A cleaner space\nstarts here!',
                        subtitle:
                            'Cleaning Service is here to keep your home, office, or apartment clean with trusted and professional cleaners.',
                      ),
                      SizedBox(height: 30.h),
                      CustomTextField(
                        controller: _usernameController,
                        hintText: 'Set your username',
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Enter your email address..',
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return Validators.email(value);
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Set your preferred password..',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                        ),
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          return Validators.password(value);
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm your password..',
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                        ),
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        controller: _phoneController,
                        hintText: 'Enter your mobile number..',
                        prefixIcon: const Icon(
                          Icons.phone_android,
                          color: Colors.grey,
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          return Validators.phone(value);
                        },
                      ),
                      SizedBox(height: 32.h),
                      CustomButton(
                        text: 'Create Account',
                        isLoading: state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                              name: _usernameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              phone: _phoneController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 32.h),
                      const OrDivider(text: 'Or sign up with'),
                      SizedBox(height: 24.h),
                      const SocialLoginRow(),
                      SizedBox(height: 40.h),
                      HaveAndNotHaveAccountWidget(
                        text: "Need premium laundry services?",
                        buttonText: "Sign in now!",
                        onPressed: () {
                          context.pop();
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
