import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/custom_button.dart';

class SubscriptionPlansPage extends StatelessWidget {
  const SubscriptionPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(
        context,
        title: "Subscription Plans",
        onBack: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Let Us Take Care\nOf The Laundry!",
              textAlign: TextAlign.center,
              style: AppTextStyles.pageTitle.copyWith(
                fontSize: 24.sp,
                color: AppColors.primary,
                height: 1.2,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Tailored Plans for all families\nBenefit from Hotel 5 Stars Quality",
              textAlign: TextAlign.center,
              style: AppTextStyles.caption,
            ),
            SizedBox(height: 30.h),

            _PackageCard(
              title: "Starter Package",
              itemsCount: "50 Items",
              price: "150 AED",
              color: AppColors.primaryLight,
            ),
            _PackageCard(
              title: "Mom's Favorite Package",
              itemsCount: "100 Items",
              price: "250 AED",
              color: AppColors.primary,
            ),
            _PackageCard(
              title: "VIP Package",
              itemsCount: "175 Items",
              price: "350 AED",
              color: AppColors.primaryDark,
            ),

            SizedBox(height: 20.h),
            CustomButton(
              text: "Go Back",
              isOutlined: true,
              onPressed: () => context.pop(),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final String title;
  final String itemsCount;
  final String price;
  final Color color;

  const _PackageCard({
    required this.title,
    required this.itemsCount,
    required this.price,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                itemsCount,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    "per month",
                    style: TextStyle(fontSize: 10.sp, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.primary,
              minimumSize: Size(120.w, 40.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              elevation: 0,
            ),
            child: Text(
              "Order Now",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
