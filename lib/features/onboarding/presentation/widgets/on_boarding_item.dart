import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/constants/app_assets.dart';
import 'package:laundry/core/theme/app_text_styles.dart';
import 'package:laundry/core/widgets/app_cached_image.dart';
import 'package:laundry/core/widgets/custom_button.dart';
import 'package:laundry/features/onboarding/domain/entities/on_boarding_slide_entity.dart';
import 'package:laundry/features/onboarding/presentation/widgets/custom_dots_indicator.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem({
    super.key,
    required this.slide,
    required this.currentIndex,
    required this.totalPages,
    required this.buttonText,
    this.onButtonPressed,
  });

  final OnBoardingSlideEntity slide;
  final int currentIndex;
  final int totalPages;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          slide.title,
          style: AppTextStyles.onBoardingTitle,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          slide.description,
          style: AppTextStyles.onBoardingDescription,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        CustomDottsIndicator(
          totalPages: totalPages,
          currentIndex: currentIndex,
        ),
        SizedBox(height: 24.h),
        Expanded(
          child: AppCachedImage(
            imageUrl: slide.image,
            assetPath: AppAssets.onBoardingImg,
          ),
        ),

        SizedBox(height: 10.h),
        CustomButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: onButtonPressed,
          text: buttonText,
          width: 380.w,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
