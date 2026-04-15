import 'package:flutter/material.dart';

import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/theme/app_text_styles.dart';

class OrderPriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const OrderPriceRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final valueTextStyle =
        isBold
            ? AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: valueColor ?? AppColors.primary,
            )
            : AppTextStyles.bodyMedium.copyWith(color: valueColor);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              isBold
                  ? AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  )
                  : AppTextStyles.caption,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/icon_price.png', width: 14, height: 14),
            const SizedBox(width: 6),
            Text(value, style: valueTextStyle),
          ],
        ),
      ],
    );
  }
}
