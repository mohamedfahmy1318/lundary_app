import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/constants/app_colors.dart';

class HaveAndNotHaveAccountWidget extends StatelessWidget {
  const HaveAndNotHaveAccountWidget({
    super.key,
    required this.text,
    required this.buttonText,
    required this.onPressed,
  });
  final String text;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
