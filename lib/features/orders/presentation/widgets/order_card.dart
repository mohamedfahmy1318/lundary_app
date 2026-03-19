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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(order.orderNumber, style: AppTextStyles.bodyMedium),
                      Text(
                        order.status.uiName,
                        style: AppTextStyles.caption.copyWith(
                          color: order.status.uiColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'AED ${order.totalAmount}  ·  ${order.itemsCount} items',
                    style: AppTextStyles.caption,
                  ),
                ],
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
    IconData iconData;

    switch (order.status) {
      case OrderStatus.pending:
        iconData = Icons.schedule;
      case OrderStatus.confirmed:
      case OrderStatus.pickingUp:
      case OrderStatus.pickedUp:
      case OrderStatus.processing:
      case OrderStatus.ready:
        iconData = Icons.sync;
      case OrderStatus.outForDelivery:
        iconData = Icons.local_shipping;
      case OrderStatus.delivered:
      case OrderStatus.completed:
        iconData = Icons.check;
      case OrderStatus.cancelled:
        iconData = Icons.close;
    }

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(color: order.status.uiColor, shape: BoxShape.circle),
      child: Icon(iconData, color: AppColors.white, size: 24.sp),
    );
  }
}
