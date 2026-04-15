import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/theme/app_text_styles.dart';

/// Eliminates the repetitive AppBar pattern used across all pages.
///
/// Usage:
/// ```dart
/// appBar: AppBarFactory.build(context, title: "Page Title"),
/// ```
class AppBarFactory {
  AppBarFactory._();

  static AppBar build(
    BuildContext context, {
    required String title,
    List<Widget>? actions,
    VoidCallback? onBack,
    Color? backgroundColor,
    bool showBack = true,
  }) {
    return AppBar(
      leading:
          showBack
              ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textPrimary,
                  size: 20.sp,
                ),
                onPressed: Navigator.of(context).pop,
              )
              : null,
      title: Text(title, style: AppTextStyles.pageTitle),
      actions: actions,
      backgroundColor: backgroundColor ?? AppColors.white,
      elevation: 0,
      centerTitle: true,
    );
  }
}
