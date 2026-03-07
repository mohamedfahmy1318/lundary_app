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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                      SizedBox(height: 60.h),
                      const AuthHeader(
                        title: 'Welcome Back',
                        subtitle:
                            'Cleaning Service is here to keep your home, office, or apartment clean with trusted and professional cleaners.',
                      ),
                      SizedBox(height: 60.h),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Enter your email address..',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color(0xffb6b6b7),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return Validators.email(value);
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Set your preferred password..',
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color(0xffb6b6b7),
                        ),
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xffb6b6b7),
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
                      SizedBox(height: 32.h),
                      CustomButton(
                        text: 'Sign In',
                        isLoading: state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().login(
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(height: 32.h),
                      const OrDivider(text: 'Or sign in with'),
                      SizedBox(height: 24.h),
                      const SocialLoginRow(),
                      SizedBox(height: 120.h),
                      HaveAndNotHaveAccountWidget(
                        text: "Don't have an account?",
                        buttonText: "Sign up now!",
                        onPressed: () {
                          context.pushNamed('register');
                        },
                      ),
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
