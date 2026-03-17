import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
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
            Text("Order #${order.orderNumber}", style: AppTextStyles.caption),
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
                            '${order.itemsCount} items',
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
                      Expanded(
                        child: _DateTimeColumn(
                          label: 'Pickup',
                          date: order.pickupDate ?? '-',
                          time: order.pickupTimeSlot ?? '-',
                        ),
                      ),
                      Expanded(
                        child: _DateTimeColumn(
                          label: 'Delivery',
                          date: order.deliveryDate ?? '-',
                          time: order.deliveryTimeSlot ?? '-',
                        ),
                      ),
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
            if (order.items != null && order.items!.isNotEmpty)
              ...order.items!.map((item) => _OrderItemRow(item: item))
            else
              const Center(child: Text("No detailed items for this order")),

            SizedBox(height: 20.h),

            // Price Summary
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  _PriceRow(label: 'Subtotal', value: order.subtotal),
                  SizedBox(height: 8.h),
                  _PriceRow(label: 'Delivery Fee', value: order.deliveryFee),
                  if (double.tryParse(order.discountAmount) != 0.0) ...[
                    SizedBox(height: 8.h),
                    _PriceRow(
                      label: 'Discount',
                      value: '-${order.discountAmount}',
                      valueColor: Colors.green,
                    ),
                  ],
                  Divider(height: 24.h),
                  _PriceRow(
                    label: 'Total',
                    value: order.totalAmount,
                    isBold: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}

class _DateTimeColumn extends StatelessWidget {
  final String label;
  final String date;
  final String time;

  const _DateTimeColumn({
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

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
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
        Text(
          'AED $value',
          style:
              isBold
                  ? AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: valueColor ?? AppColors.primary,
                  )
                  : AppTextStyles.bodyMedium.copyWith(color: valueColor),
        ),
      ],
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final OrderItemModel item;

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
                Text(item.serviceName, style: AppTextStyles.bodyMedium),
                Text(
                  "AED ${item.unitPrice}/Item",
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          Text("${item.quantity}", style: AppTextStyles.bodyMedium),
          SizedBox(width: 40.w),
          Text(
            "AED ${item.totalPrice}",
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
