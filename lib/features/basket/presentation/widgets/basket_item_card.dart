import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/basket_item_model.dart';

class BasketItemCard extends StatelessWidget {
  final BasketItemModel item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const BasketItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder for Image/Icon
          Container(
            width: 60.w,
            height: 60.w,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.checkroom, color: Colors.grey[400], size: 30.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            item.name,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(item.category, style: AppTextStyles.captionSmall),
          SizedBox(height: 12.h),

          // Quantity Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _QuantityButton(icon: Icons.remove, onTap: onDecrement),
              SizedBox(width: 12.w),
              Text(
                "${item.quantity}",
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 12.w),
              _QuantityButton(icon: Icons.add, onTap: onIncrement),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: const BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16.sp, color: AppColors.primary),
      ),
    );
  }
}
