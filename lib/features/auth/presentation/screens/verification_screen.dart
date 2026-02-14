import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/theme/app_text_styles.dart';
import 'package:laundry/core/widgets/app_bar_factory.dart';
import 'package:laundry/features/auth/presentation/widgets/otp_field.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(context, title: 'Verification'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Text(
                'A verification code has been sent to',
                style: AppTextStyles.onBoardingDescription.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '+971 1 123 123 1234',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 30.h),
              OtpInputField(
                length: 5,
                onCompleted: (code) {
                  // TODO: Verify OTP with API, then navigate
                  debugPrint('OTP entered: $code');
                  context.goNamed('selectAddress');
                },
              ),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    // Resend logic
                  },
                  child: Text(
                    'Resend code?',
                    style: AppTextStyles.onBoardingDescription.copyWith(
                      color: AppColors.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: 'You can resend the code in ',
                    style: AppTextStyles.onBoardingDescription.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: '24 seconds',
                        style: AppTextStyles.onBoardingDescription.copyWith(
                          color: AppColors.primary,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
