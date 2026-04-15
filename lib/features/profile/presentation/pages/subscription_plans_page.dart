import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import 'package:laundry/core/di/injection_container.dart';
import '../../domain/entities/active_subscription_entity.dart';
import '../../domain/entities/subscription_plan_entity.dart';
import '../cubit/subscriptions_cubit.dart';
import '../cubit/subscriptions_state.dart';

class SubscriptionPlansPage extends StatelessWidget {
  const SubscriptionPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SubscriptionsCubit>()..loadSubscriptions(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBarFactory.build(
            context,
            title: "Subscriptions",
            onBack: () => context.pop(),
          ),
          body: Column(
            children: [
              TabBar(
                labelColor: AppColors.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.primary,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: "Available Plans"),
                  Tab(text: "My Subscriptions"),
                ],
              ),
              Expanded(
                child: BlocBuilder<SubscriptionsCubit, SubscriptionsState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox.shrink(),
                      loading:
                          () =>
                              const Center(child: CircularProgressIndicator()),
                      error: (msg) => Center(child: Text(msg)),
                      loaded: (plans, mySubscriptions) {
                        return TabBarView(
                          children: [
                            _AvailablePlansTab(plans: plans),
                            _MySubscriptionsTab(
                              mySubscriptions: mySubscriptions,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvailablePlansTab extends StatelessWidget {
  final List<SubscriptionPlanEntity> plans;

  const _AvailablePlansTab({required this.plans});

  @override
  Widget build(BuildContext context) {
    if (plans.isEmpty) {
      return Center(
        child: Text(
          "No plans available at the moment.",
          style: AppTextStyles.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      itemCount: plans.length,
      itemBuilder: (context, index) {
        final plan = plans[index];
        return _PlanCard(
          title: plan.name,
          itemsCount:
              plan.unlimitedItems
                  ? "Unlimited Items"
                  : "${plan.itemLimit} Items",
          price: plan.price,
          duration: "${plan.durationDays} Days",
          isActive: plan.isActive,
        );
      },
    );
  }
}

class _MySubscriptionsTab extends StatelessWidget {
  final List<ActiveSubscriptionEntity> mySubscriptions;

  const _MySubscriptionsTab({required this.mySubscriptions});

  @override
  Widget build(BuildContext context) {
    if (mySubscriptions.isEmpty) {
      return Center(
        child: Text(
          "You have no active subscriptions.",
          style: AppTextStyles.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      itemCount: mySubscriptions.length,
      itemBuilder: (context, index) {
        final sub = mySubscriptions[index];
        return _ActiveSubscriptionCard(subscription: sub);
      },
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String itemsCount;
  final String price;
  final String duration;
  final bool isActive;

  const _PlanCard({
    required this.title,
    required this.itemsCount,
    required this.price,
    required this.duration,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.primary;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              if (!isActive)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    "Inactive",
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    itemsCount,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (price == "0.00")
                    Text(
                      "FREE",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    )
                  else
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/icon_price.png',
                          width: 14.w,
                          height: 14.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  Text(
                    duration,
                    style: TextStyle(fontSize: 10.sp, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: isActive ? () {} : null,
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
              "Subscribe Now",
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

class _ActiveSubscriptionCard extends StatelessWidget {
  final ActiveSubscriptionEntity subscription;

  const _ActiveSubscriptionCard({required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border.all(color: AppColors.primaryLight),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subscription.plan.name.toUpperCase(),
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color:
                      subscription.status == 'active'
                          ? Colors.green
                          : Colors.grey,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  subscription.status.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildDetailRow(
            "Items Used",
            "${subscription.itemsUsed} / ${subscription.plan.itemLimit}",
          ),
          SizedBox(height: 8.h),
          _buildDetailRow("Expires On", subscription.endsAt.split('T').first),
          SizedBox(height: 8.h),
          _buildDetailRow(
            "Amount Paid",
            subscription.amountPaid,
            showPriceIcon: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool showPriceIcon = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey[600]),
        ),
        if (showPriceIcon)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/icon_price.png',
                width: 14.w,
                height: 14.w,
              ),
              SizedBox(width: 4.w),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        else
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}
