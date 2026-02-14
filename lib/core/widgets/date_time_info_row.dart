import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/theme/app_text_styles.dart';

/// A row showing a date and time with calendar/clock icons.
///
/// Used in order details, payment summary, schedule confirmation, etc.
///
/// Usage:
/// ```dart
/// DateTimeInfoRow(date: "July-20-2025", time: "09:00 WIB")
/// ```
class DateTimeInfoRow extends StatelessWidget {
  final String date;
  final String time;
  final bool spaceBetween;

  const DateTimeInfoRow({
    super.key,
    required this.date,
    required this.time,
    this.spaceBetween = false,
  });

  @override
  Widget build(BuildContext context) {
    final dateWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.calendar_today, size: 16.sp, color: AppColors.primary),
        SizedBox(width: 8.w),
        Text(
          date,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );

    final timeWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.access_time, size: 16.sp, color: AppColors.primary),
        SizedBox(width: 8.w),
        Text(
          time,
          style: AppTextStyles.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );

    if (spaceBetween) {
      return Row(children: [dateWidget, const Spacer(), timeWidget]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dateWidget,
        SizedBox(height: 4.h),
        timeWidget,
      ],
    );
  }
}
