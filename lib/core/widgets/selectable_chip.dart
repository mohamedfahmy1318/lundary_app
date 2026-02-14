import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/constants/app_colors.dart';

/// Reusable toggle chip for tabs, filters, and category selectors.
///
/// Replaces duplicated tab-bar-like UI in `BasketPage`, `OrdersPage`,
/// `NewTicketPage`, and `TimeSlotChip`.
///
/// Usage:
/// ```dart
/// SelectableChip(
///   label: "Washing",
///   isSelected: true,
///   onTap: () {},
/// )
/// ```
class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const SelectableChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: AppColors.primary),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: fontSize ?? 12.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
