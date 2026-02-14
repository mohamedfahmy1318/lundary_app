import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/selectable_chip.dart';

class NewTicketPage extends StatefulWidget {
  const NewTicketPage({super.key});

  @override
  State<NewTicketPage> createState() => _NewTicketPageState();
}

class _NewTicketPageState extends State<NewTicketPage> {
  String? _selectedCategory;
  final List<String> _categories = [
    "Order Issue",
    "Delivery Problem",
    "Quality Complaint",
    "Refund Request",
    "Payment Issue",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(context, title: "New Ticket"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Create Support Ticket", style: AppTextStyles.sectionTitle),
            SizedBox(height: 8.h),
            Text(
              "We're here to help. Describe your issue below.",
              style: AppTextStyles.bodyRegular,
            ),
            SizedBox(height: 30.h),

            // Categories
            Text("Select Category *", style: AppTextStyles.sectionLabel),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 12.h,
              children: _categories.map((category) {
                return SelectableChip(
                  label: category,
                  isSelected: _selectedCategory == category,
                  onTap: () {
                    setState(() {
                      _selectedCategory = _selectedCategory == category
                          ? null
                          : category;
                    });
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 24.h),

            // Order Number
            _buildLabeledField(
              label: "Order Number (Optional)",
              hint: "e.g., #123456",
            ),
            SizedBox(height: 24.h),

            // Description
            _buildLabeledField(
              label: "Describe Your Issue *",
              hint: "Please provide details about your issue...",
              maxLines: 5,
            ),
            SizedBox(height: 24.h),

            // Attach Image
            Text("Attach Image (Optional)", style: AppTextStyles.sectionLabel),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              height: 100.h,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: Colors.grey[300]!, width: 1.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    color: AppColors.textHint,
                    size: 30.sp,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Tap to upload image",
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "PNG, JPG up to 10MB",
                    style: AppTextStyles.captionSmall,
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Submit Button
            CustomButton(text: "Submit Ticket", onPressed: () => context.pop()),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLabeledField({
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.sectionLabel),
        SizedBox(height: 12.h),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13.sp),
            filled: true,
            fillColor: AppColors.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}
