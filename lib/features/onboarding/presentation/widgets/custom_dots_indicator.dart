import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/constants/app_colors.dart';

class CustomDottsIndicator extends StatelessWidget {
  const CustomDottsIndicator({
    super.key,
    required this.totalPages,
    required this.currentIndex,
  });

  final int totalPages;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        final bool isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.textHint,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
