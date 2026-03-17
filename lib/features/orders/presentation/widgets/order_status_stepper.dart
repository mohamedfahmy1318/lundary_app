import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/order_model.dart';

class OrderStatusStepper extends StatelessWidget {
  final OrderStatus status;

  const OrderStatusStepper({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final int activeStep = _getActiveStep();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Row(
        children: [
          _buildStep("Picking up", activeStep >= 0),
          _buildLine(activeStep >= 1),
          _buildStep("Processing", activeStep >= 1),
          _buildLine(activeStep >= 2),
          _buildStep("Delivery\non the way", activeStep >= 2),
          _buildLine(activeStep >= 3),
          _buildStep("Completed", activeStep >= 3),
        ],
      ),
    );
  }

  int _getActiveStep() {
    switch (status) {
      case OrderStatus.pending:
        return 0;
      case OrderStatus.confirmed:
      case OrderStatus.pickedUp:
        return 1;
      case OrderStatus.processing:
      case OrderStatus.ready:
        return 2;
      case OrderStatus.outForDelivery:
        return 3;
      case OrderStatus.delivered:
      case OrderStatus.completed:
        return 4;
      case OrderStatus.cancelled:
        return -1;
    }
  }

  Widget _buildStep(String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.primary : AppColors.white,
            border: Border.all(
              color: isActive ? AppColors.primary : Colors.grey.shade300,
              width: 3.w,
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9.sp,
            color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2.h,
        color: isActive ? AppColors.primary : Colors.grey.shade300,
        margin: EdgeInsets.only(bottom: 20.h, left: 2.w, right: 2.w),
      ),
    );
  }
}
