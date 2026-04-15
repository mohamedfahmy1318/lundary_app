import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/theme/app_text_styles.dart';

class VerificationHeaderSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String email;
  final String? message;

  const VerificationHeaderSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.email,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.h),
        Text(
          title,
          style: AppTextStyles.pageTitle.copyWith(
            fontSize: 16.sp,
            color: AppColors.textSecondary,
          ),
        ),

        SizedBox(height: 10.h),
        Text(
          email,
          style: AppTextStyles.sectionLabel.copyWith(
            fontSize: 15.sp,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class VerificationResendSection extends StatelessWidget {
  final bool canResend;
  final bool isLoading;
  final String formattedRemaining;
  final VoidCallback onResend;

  const VerificationResendSection({
    super.key,
    required this.canResend,
    required this.isLoading,
    required this.formattedRemaining,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: canResend && !isLoading ? onResend : null,
            child: Text(
              'Resend code',
              style: AppTextStyles.onBoardingDescription.copyWith(
                color: canResend ? AppColors.primary : AppColors.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          canResend
              ? 'You can request a new code now.'
              : 'You can resend the code in $formattedRemaining',
          style: AppTextStyles.onBoardingDescription.copyWith(
            color: AppColors.textSecondary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
