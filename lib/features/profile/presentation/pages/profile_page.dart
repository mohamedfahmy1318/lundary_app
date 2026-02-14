import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/routing_names.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(
        context,
        title: "Profile",
        onBack: () => context.go(RoutingNames.home),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: 100.h),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            // Avatar
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
            ),
            SizedBox(height: 16.h),
            Text("Edward Bastoni", style: AppTextStyles.pageTitle),
            SizedBox(height: 4.h),
            Text("edwardbastoni22@gmail.com", style: AppTextStyles.bodyRegular),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Divider(color: Colors.grey[300]),
            ),
            SizedBox(height: 30.h),

            // Menu Items
            _ProfileMenuItem(
              icon: Icons.person,
              label: "Manage Account",
              onTap: () => context.pushNamed('manageAccount'),
            ),
            _ProfileMenuItem(
              icon: Icons.calendar_today,
              label: "My Subscriptions",
              onTap: () => context.pushNamed('subscriptionPlans'),
            ),
            _ProfileMenuItem(
              icon: Icons.access_time,
              label: "Orders",
              onTap: () {},
            ),
            _ProfileMenuItem(
              icon: Icons.credit_card,
              label: "E-Wallet & Payment Method",
              onTap: () => context.pushNamed('wallet'),
            ),
            _ProfileMenuItem(
              icon: Icons.headset_mic,
              label: "Support",
              onTap: () => context.pushNamed('support'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Extracted as a private widget to keep ProfilePage's build method clean.
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: Material(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(30.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppColors.white, size: 20.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(child: Text(label, style: AppTextStyles.bodyMedium)),
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.textPrimary,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
