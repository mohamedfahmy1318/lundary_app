import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/constants/app_colors.dart';

abstract class AppTextStyles {
  // ── Page & Section Titles ──
  static final TextStyle pageTitle = GoogleFonts.urbanist(
    fontSize: 18.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  static final TextStyle sectionTitle = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle sectionLabel = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ── Body Text ──
  static final TextStyle bodyMedium = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static final TextStyle bodyRegular = GoogleFonts.poppins(
    fontSize: 14.sp,
    color: AppColors.textSecondary,
  );

  static final TextStyle caption = GoogleFonts.poppins(
    fontSize: 12.sp,
    color: AppColors.textSecondary,
  );

  static final TextStyle captionSmall = GoogleFonts.poppins(
    fontSize: 10.sp,
    color: AppColors.textSecondary,
  );

  // ── OnBoarding (legacy, kept for backward compat) ──
  static final TextStyle onBoardingTitle = TextStyle(
    fontSize: 25.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static final TextStyle onBoardingDescription = GoogleFonts.urbanist(
    fontSize: 14.sp,
    color: AppColors.textSecondary,
  );

  // ── Button ──
  static final TextStyle buttonTextStyle = GoogleFonts.urbanist(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
