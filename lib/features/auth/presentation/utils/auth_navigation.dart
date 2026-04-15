import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/widgets/app_dialogs.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_state.dart';
import 'package:laundry/features/auth/presentation/models/verification_params.dart';

abstract final class AuthNavigation {
  static void handleEntryFlowState(BuildContext context, AuthState state) {
    state.maybeWhen(
      otpRequested: (purpose, email, challenge) {
        final params = VerificationParams.fromChallenge(
          purpose: purpose,
          email: email,
          challenge: challenge,
        );
        context.pushNamed(
          'verification',
          queryParameters: params.toQueryParameters(),
        );
      },
      authenticated: (_) {
        context.goNamed('main');
      },
      error: (message) {
        AppDialogs.showMessage(
          context,
          title: 'Error',
          message: message,
          isError: true,
        );
      },
      orElse: () {},
    );
  }
}
