import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/date_time_info_row.dart';

class OrderSummaryCard extends StatelessWidget {
  final String title;
  final String itemCount;
  final String pickupDate;
  final String pickupTime;
  final String deliveryDate;
  final String deliveryTime;
  final VoidCallback? onViewDetails;

  const OrderSummaryCard({
    super.key,
    required this.title,
    required this.itemCount,
    required this.pickupDate,
    required this.pickupTime,
    required this.deliveryDate,
    required this.deliveryTime,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.shopping_bag, color: Colors.grey[500]),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(itemCount, style: AppTextStyles.caption),
                  GestureDetector(
                    onTap: onViewDetails,
                    child: Text(
                      "View order details",
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          DateTimeInfoRow(
            date: pickupDate,
            time: pickupTime,
            spaceBetween: true,
          ),
          SizedBox(height: 8.h),
          DateTimeInfoRow(
            date: deliveryDate,
            time: deliveryTime,
            spaceBetween: true,
          ),
        ],
      ),
    );
  }
}
