import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/constants/app_colors.dart';

/// A single category chip (icon + label).
/// Shows a highlighted outline when [isSelected] is true.
class CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? imageUrl;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.icon,
    this.imageUrl,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24.w,
              height: 24.w,
              child: ClipOval(
                child:
                    imageUrl != null && imageUrl!.trim().isNotEmpty
                        ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          fit: BoxFit.cover,
                          placeholder:
                              (_, __) => Icon(
                                icon,
                                color:
                                    isSelected
                                        ? AppColors.primary
                                        : Colors.grey,
                                size: 20.sp,
                              ),
                          errorWidget:
                              (_, __, ___) => Icon(
                                icon,
                                color:
                                    isSelected
                                        ? AppColors.primary
                                        : Colors.grey,
                                size: 20.sp,
                              ),
                        )
                        : Icon(
                          icon,
                          color: isSelected ? AppColors.primary : Colors.grey,
                          size: 20.sp,
                        ),
              ),
            ),
            if (isSelected) ...[
              SizedBox(width: 8.w),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
