import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/theme/app_text_styles.dart';

/// Reusable header widget for auth screens.
/// Shows a bold [title] and a grey [subtitle] centered below it.
class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.onBoardingTitle.copyWith(
            fontSize: 24.sp,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.onBoardingDescription.copyWith(
            color: const Color(0xffb6b6b7),
          ),
        ),
      ],
    );
  }
}
