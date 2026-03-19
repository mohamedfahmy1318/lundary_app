import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import 'package:laundry/core/di/injection_container.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ProfileCubit>()..loadProfile()),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            unauthenticated: () => context.goNamed('login'),
            error: (msg) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg), backgroundColor: Colors.red),
              );
            },
          );
        },
        child: Scaffold(
          backgroundColor: AppColors.white,
        appBar: AppBarFactory.build(context, title: "Profile", showBack: false),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (msg) => Center(child: Text(msg)),
              loaded: (profile) {
                return SingleChildScrollView(
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
                          image:
                              profile.fullAvatarUrl != null
                                  ? DecorationImage(
                                    image: NetworkImage(profile.fullAvatarUrl!),
                                    fit: BoxFit.cover,
                                  )
                                  : null,
                        ),
                        child:
                            profile.fullAvatarUrl == null
                                ? Icon(
                                  Icons.person,
                                  size: 50.sp,
                                  color: Colors.grey[600],
                                )
                                : null,
                      ),
                      SizedBox(height: 16.h),
                      Text(profile.name, style: AppTextStyles.pageTitle),
                      SizedBox(height: 4.h),
                      Text(profile.email, style: AppTextStyles.bodyRegular),
                      if (profile.walletBalance != null) ...[
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            "Wallet: \$${profile.walletBalance}",
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
                        label: "Subscriptions",
                        onTap: () => context.pushNamed('subscriptionPlans'),
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
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          final isLoading = state.maybeWhen(
                            loading: () => true,
                            orElse: () => false,
                          );
                          return _ProfileMenuItem(
                            icon: Icons.logout,
                            label: isLoading ? "Logging out..." : "Logout",
                            onTap: isLoading
                                ? () {}
                                : () => context.read<AuthCubit>().logout(),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
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
