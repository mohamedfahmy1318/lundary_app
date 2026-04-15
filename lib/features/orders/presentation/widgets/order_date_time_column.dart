import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:laundry/core/theme/app_text_styles.dart';

class OrderDateTimeColumn extends StatelessWidget {
  final String label;
  final String date;
  final String time;

  const OrderDateTimeColumn({
    super.key,
    required this.label,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.caption),
        SizedBox(height: 4.h),
        Text(date, style: AppTextStyles.bodyMedium),
        Text(time, style: AppTextStyles.caption),
      ],
    );
  }
}
