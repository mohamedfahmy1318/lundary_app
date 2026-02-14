import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  const OrderCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          children: [
            _buildStatusIcon(),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'Order ${order.id} (${order.locationName})',
                style: AppTextStyles.bodyMedium,
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: AppColors.textPrimary,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon() {
    Color iconColor;
    IconData iconData;

    switch (order.status) {
      case OrderStatus.inProgress:
        iconColor = AppColors.success;
        iconData = Icons.sync;
        break;
      case OrderStatus.deliveryOnTheWay:
        iconColor = AppColors.warning;
        iconData = Icons.local_shipping;
        break;
      case OrderStatus.completed:
        iconColor = AppColors.primary;
        iconData = Icons.check;
        break;
      case OrderStatus.cancelled:
        iconColor = AppColors.error;
        iconData = Icons.close;
        break;
    }

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
      child: Icon(iconData, color: AppColors.white, size: 24.sp),
    );
  }
}
