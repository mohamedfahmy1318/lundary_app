import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final VoidCallback onRefill;

  const BalanceCard({super.key, required this.balance, required this.onRefill});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                size: 16.sp,
                color: AppColors.white.withValues(alpha: 0.8),
              ),
              SizedBox(width: 6.w),
              Text(
                "Total Balance",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "D ${balance.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Available Credits",
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 36.h,
            child: ElevatedButton.icon(
              onPressed: onRefill,
              icon: Icon(Icons.add, size: 16.sp),
              label: Text(
                "Refill Credits",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
