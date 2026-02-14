import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/widgets/custom_button.dart';

/// The draggable bottom card shown on the Select Address screen.
///
/// Displays a [nickname] label, a helper [hint] text,
/// a **Save** button and a **Cancel** button.
class AddressBottomCard extends StatelessWidget {
  final String nickname;
  final String hint;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const AddressBottomCard({
    super.key,
    required this.nickname,
    required this.hint,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),

          // Nickname row + Save button
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Nickname:  ',
                        style: GoogleFonts.poppins(
                          fontSize: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: nickname,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      hint,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 90.w,
                height: 38.h,
                child: CustomButton(text: 'Save', onPressed: onSave),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Cancel button
          CustomButton(text: 'Cancel', isOutlined: true, onPressed: onCancel),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
