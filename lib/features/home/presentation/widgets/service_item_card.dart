import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/constants/app_colors.dart';

/// A service card showing image placeholder, name, price and ± controls.
class ServiceItemCard extends StatelessWidget {
  final String name;
  final double price;
  final String? imageUrl;
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const ServiceItemCard({
    super.key,
    required this.name,
    required this.price,
    this.imageUrl,
    this.quantity = 0,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image placeholder
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child:
                  imageUrl != null && imageUrl!.trim().isNotEmpty
                      ? CachedNetworkImage(
                        imageUrl: imageUrl!,
                        fit: BoxFit.cover,
                        placeholder:
                            (_, __) => Icon(
                              Icons.checkroom,
                              color: Colors.grey[400],
                              size: 28.sp,
                            ),
                        errorWidget:
                            (_, __, ___) => Icon(
                              Icons.checkroom,
                              color: Colors.grey[400],
                              size: 28.sp,
                            ),
                      )
                      : Icon(
                        Icons.checkroom,
                        color: Colors.grey[400],
                        size: 28.sp,
                      ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),
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
                price.toStringAsFixed(0),
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Quantity controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CircleBtn(icon: Icons.remove, onTap: onDecrement),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Text(
                  '$quantity',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              _CircleBtn(icon: Icons.add, onTap: onIncrement),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleBtn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
          border: Border.all(color: AppColors.primary, width: 1.5),
        ),
        child: Icon(icon, size: 16.sp, color: AppColors.primary),
      ),
    );
  }
}
