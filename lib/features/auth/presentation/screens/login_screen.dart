import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/core/services/push_notification_service.dart';
import 'package:laundry/core/services/social_auth_service.dart';
import 'package:laundry/core/widgets/app_dialogs.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_state.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_state_x.dart';
import 'package:laundry/features/auth/presentation/utils/auth_navigation.dart';
import 'package:laundry/features/auth/presentation/widgets/forms/login_form_view.dart';

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

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _submitLogin(BuildContext context) {
    context.read<AuthCubit>().requestLoginOtp(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );
  }

  String _resolveDeviceType() {
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => 'ios',
      TargetPlatform.android => 'android',
      _ => 'android',
    };
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      final firebaseToken =
          await SocialAuthService.signInWithGoogleAndGetFirebaseToken();

      if (!mounted || firebaseToken == null || firebaseToken.isEmpty) {
        return;
      }

      String fcmToken = '';
      try {
        fcmToken = await PushNotificationService.getToken();
      } catch (_) {
        fcmToken = '';
      }

      if (!context.mounted) {
        return;
      }

      context.read<AuthCubit>().socialLogin(
        firebaseToken: firebaseToken,
        fcmToken: fcmToken,
        deviceType: _resolveDeviceType(),
      );
    } on SocialAuthException catch (e) {
      if (!mounted) {
        return;
      }

      AppDialogs.showMessage(
        context,
        title: 'Google Sign-In Failed',
        message: e.message,
        isError: true,
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      AppDialogs.showMessage(
        context,
        title: 'Google Sign-In Failed',
        message: 'Unable to sign in with Google. Please try again.',
        isError: true,
      );
    }
  }

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
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              AuthNavigation.handleEntryFlowState(context, state);
            },
            child: BlocSelector<AuthCubit, AuthState, bool>(
              selector: (state) => state.isLoading,
              builder: (context, isLoading) {
                return LoginFormView(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  isPasswordObscured: _obscurePassword,
                  isLoading: isLoading,
                  onTogglePasswordVisibility: _togglePasswordVisibility,
                  onSubmit: () => _submitLogin(context),
                  onGoogleTap: () => _handleGoogleSignIn(context),
                  onNavigateToRegister: () => context.pushNamed('register'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
