import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/routing_names.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success Icon
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 80.sp,
                    color: AppColors.success,
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  "Payment Successful!",
                  style: AppTextStyles.pageTitle.copyWith(fontSize: 24.sp),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Your order has been placed successfully.\nWe will pick it up as scheduled.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyRegular.copyWith(height: 1.5),
                ),
                SizedBox(height: 48.h),
                CustomButton(
                  text: "Back to Home",
                  onPressed: () => context.go(RoutingNames.main),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
