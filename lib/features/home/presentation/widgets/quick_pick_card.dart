import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/constants/app_colors.dart';

/// A product card showing circular image, name, category, and ± quantity controls.
class QuickPickCard extends StatelessWidget {
  final String name;
  final String category;
  final String? imageUrl;
  final int quantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const QuickPickCard({
    super.key,
    required this.name,
    required this.category,
    this.imageUrl,
    this.quantity = 0,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image placeholder
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
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
                              color: Colors.grey[500],
                              size: 28.sp,
                            ),
                        errorWidget:
                            (_, __, ___) => Icon(
                              Icons.checkroom,
                              color: Colors.grey[500],
                              size: 28.sp,
                            ),
                      )
                      : Icon(
                        Icons.checkroom,
                        color: Colors.grey[500],
                        size: 28.sp,
                      ),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            category,
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 10.h),
          // Quantity controls
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCircleButton(icon: Icons.remove, onTap: onDecrement),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  '$quantity',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              _buildCircleButton(icon: Icons.add, onTap: onIncrement),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 1.5),
        ),
        child: Icon(icon, size: 16.sp, color: AppColors.primary),
      ),
    );
  }
}
