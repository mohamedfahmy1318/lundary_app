import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/core/services/push_notification_service.dart';
import 'package:laundry/core/widgets/app_bar_factory.dart';
import 'package:laundry/core/widgets/app_dialogs.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_purpose.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_state.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_state_x.dart';
import 'package:laundry/features/auth/presentation/models/verification_params.dart';
import 'package:laundry/features/auth/presentation/widgets/otp_field.dart';
import 'package:laundry/features/auth/presentation/widgets/verification/verification_content_sections.dart';

class VerificationScreen extends StatefulWidget {
  final VerificationParams params;

  const VerificationScreen({super.key, required this.params});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late int _remainingSeconds;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.params.expiresInMinutes * 60;
    _startCountdown();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _countdownTimer?.cancel();

    if (_remainingSeconds <= 0) {
      return;
    }

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds <= 0) {
        timer.cancel();
        return;
      }

      setState(() {
        _remainingSeconds -= 1;
      });
    });
  }

  String get _formattedRemaining {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  bool get _canResend => _remainingSeconds <= 0;

  String get _subtitle {
    return switch (widget.params.purpose) {
      AuthOtpPurpose.login =>
        'A login code was sent to your email. Enter it to complete sign in.',
      AuthOtpPurpose.register =>
        'A registration code was sent to your email. Enter it to complete account creation.',
    };
  }

  Future<void> _verifyOtp(BuildContext context, String code) async {
    final trimmedCode = code.trim();
    if (trimmedCode.length != 5) {
      return;
    }

    String fcmToken = '';
    if (widget.params.purpose == AuthOtpPurpose.login) {
      fcmToken = await PushNotificationService.getToken();
    }

    if (!context.mounted) return;

    context.read<AuthCubit>().verifyOtp(
      purpose: widget.params.purpose,
      email: widget.params.email,
      otp: trimmedCode,
      fcmToken: fcmToken,
    );
  }

  void _resendOtp(BuildContext context) {
    if (!_canResend) {
      return;
    }

    context.read<AuthCubit>().resendOtp(
      email: widget.params.email,
      purpose: widget.params.purpose,
    );
  }

  void _onStateChanged(BuildContext context, AuthState state) {
    state.maybeWhen(
      authenticated: (_) {
        context.goNamed('main');
      },
      otpRequested: _handleResentOtp,
      error: (message) {
        AppDialogs.showMessage(
          context,
          title: 'Verification Failed',
          message: message,
          isError: true,
        );
      },
      orElse: () {},
    );
  }

  void _handleResentOtp(
    AuthOtpPurpose purpose,
    String email,
    AuthOtpChallengeEntity challenge,
  ) {
    if (email != widget.params.email || purpose != widget.params.purpose) {
      return;
    }

    setState(() {
      _remainingSeconds = challenge.expiresInMinutes * 60;
    });
    _startCountdown();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(challenge.message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBarFactory.build(context, title: 'Verification'),
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: _onStateChanged,
            builder: (context, state) {
              final isLoading = state.isLoading;

              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 16.h),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VerificationHeaderSection(
                            title: ' A verification code has been sent to ',
                            subtitle: _subtitle,
                            email: widget.params.email,
                            message: widget.params.message,
                          ),
                          SizedBox(height: 28.h),
                          OtpInputField(
                            length: 5,
                            onCompleted:
                                isLoading
                                    ? null
                                    : (code) async => _verifyOtp(context, code),
                          ),
                          SizedBox(height: 14.h),
                          if (isLoading)
                            const Center(child: CircularProgressIndicator()),
                          SizedBox(height: 24.h),
                          VerificationResendSection(
                            canResend: _canResend,
                            isLoading: isLoading,
                            formattedRemaining: _formattedRemaining,
                            onResend: () => _resendOtp(context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
