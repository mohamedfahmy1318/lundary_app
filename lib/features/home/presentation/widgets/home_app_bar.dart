import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/constants/app_colors.dart';

/// Top bar with location selector and cart icon.
class HomeAppBar extends StatelessWidget {
  final String location;
  final int cartCount;
  final bool isLocationLoading;
  final VoidCallback? onLocationTap;
  final VoidCallback? onCartTap;

  const HomeAppBar({
    super.key,
    required this.location,
    this.cartCount = 0,
    this.isLocationLoading = false,
    this.onLocationTap,
    this.onCartTap,
  });

  String _formatLocationForDisplay(String rawLocation) {
    final normalized =
        rawLocation
            .replaceAll(RegExp(r'\s+'), ' ')
            .replaceAll(RegExp(r'\s*,\s*'), ', ')
            .trim();

    if (normalized.isEmpty) {
      return 'Select your location';
    }

    if (normalized == 'Detecting location...' ||
        normalized == 'Location unavailable') {
      return normalized;
    }

    final parts =
        normalized
            .split(',')
            .map((part) => part.trim())
            .where((part) => part.isNotEmpty)
            .toList();

    if (parts.isEmpty) {
      return normalized;
    }

    if (parts.length == 1) {
      return _truncate(parts.first, 40);
    }

    // Show the most useful portion for quick scanning in the home header.
    return _truncate('${parts[0]}, ${parts[1]}', 44);
  }

  String _truncate(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength - 3).trimRight()}...';
  }

  @override
  Widget build(BuildContext context) {
    final displayLocation = _formatLocationForDisplay(location);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          // Location
          Expanded(
            child: GestureDetector(
              onTap: onLocationTap,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.primary,
                    size: 22.sp,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Current location',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Tooltip(
                          message: location,
                          waitDuration: const Duration(milliseconds: 350),
                          child: Text(
                            displayLocation,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4.w),
                  if (isLocationLoading)
                    SizedBox(
                      width: 16.w,
                      height: 16.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  else
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textPrimary,
                      size: 20.sp,
                    ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
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
