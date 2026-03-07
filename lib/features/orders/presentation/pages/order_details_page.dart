import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/date_time_info_row.dart';
import '../../data/models/order_model.dart';
import '../widgets/order_status_stepper.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(
        context,
        title: "Order Details",
        showBack: true,
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order ${order.id}", style: AppTextStyles.caption),
            SizedBox(height: 20.h),

            // Basket Summary
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Basket", style: AppTextStyles.sectionTitle),
                          Text(
                            order.basketItemsCount,
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DateTimeInfoRow(date: "July-20-2025", time: "09:00 WIB"),
                      DateTimeInfoRow(date: "July-22-2025", time: "18:00 WIB"),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Status Stepper
            OrderStatusStepper(status: order.status),

            SizedBox(height: 30.h),

            // Items List
            if (order.items.isNotEmpty)
              ...order.items.map((item) => _OrderItemRow(item: item))
            else
              const Center(child: Text("No detailed items for this order")),

            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final OrderItem item;

  const _OrderItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppTextStyles.bodyMedium),
                Text(
                  "\$${item.price.toStringAsFixed(2)}/Item",
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Text("${item.quantity}", style: AppTextStyles.bodyMedium),
          SizedBox(width: 40.w),
          Text(
            "\$${(item.price * item.quantity).toStringAsFixed(2)}",
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
