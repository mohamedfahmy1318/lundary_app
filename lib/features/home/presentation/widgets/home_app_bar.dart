import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/constants/app_colors.dart';

/// Top bar with location selector and cart icon.
class HomeAppBar extends StatelessWidget {
  final String location;
  final int cartCount;
  final VoidCallback? onLocationTap;
  final VoidCallback? onCartTap;

  const HomeAppBar({
    super.key,
    required this.location,
    this.cartCount = 0,
    this.onLocationTap,
    this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          // Location
          GestureDetector(
            onTap: onLocationTap,
            child: Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary, size: 22.sp),
                SizedBox(width: 6.w),
                Text(
                  location,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textPrimary,
                  size: 20.sp,
                ),
              ],
            ),
          ),
          const Spacer(),
          // Cart
          CircleAvatar(
            radius: 23.r,
            backgroundColor: AppColors.primary,
            child: GestureDetector(
              onTap: onCartTap,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: AppColors.white,
                    size: 26.sp,
                  ),
                  if (cartCount > 0)
                    Positioned(
                      right: -9,
                      top: 12,
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 45, 207, 39),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$cartCount',
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
