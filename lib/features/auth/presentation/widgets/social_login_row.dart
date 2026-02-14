import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/constants/app_assets.dart';
import 'package:laundry/core/widgets/social_button.dart';

/// A row of Apple + Google social login buttons.
/// Wraps the existing [SocialButton] widget for convenient reuse.
class SocialLoginRow extends StatelessWidget {
  final VoidCallback? onAppleTap;
  final VoidCallback? onGoogleTap;

  const SocialLoginRow({super.key, this.onAppleTap, this.onGoogleTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(
          label: 'Apple',
          icon: AppAssets.appleIcon,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          onTap: onAppleTap ?? () {},
        ),
        SizedBox(width: 16.w),
        SocialButton(
          label: 'Google',
          icon: AppAssets.googleIcon,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          onTap: onGoogleTap ?? () {},
        ),
      ],
    );
  }
}
