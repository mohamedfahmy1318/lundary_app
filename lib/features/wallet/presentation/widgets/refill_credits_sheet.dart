import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/bottom_sheet_wrapper.dart';
import '../../data/models/payment_card_model.dart';

class RefillCreditsSheet extends StatefulWidget {
  const RefillCreditsSheet({super.key});

  @override
  State<RefillCreditsSheet> createState() => _RefillCreditsSheetState();
}

class _RefillCreditsSheetState extends State<RefillCreditsSheet> {
  int _selectedAmountIndex = -1;
  int _selectedCardIndex = 0;
  final TextEditingController _customAmountController = TextEditingController();
  final List<double> _presetAmounts = [10, 25, 50, 100, 200, 500];
  final cards = PaymentCardModel.mockCards;

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }

  double get _selectedAmount {
    if (_selectedAmountIndex >= 0) return _presetAmounts[_selectedAmountIndex];
    return double.tryParse(_customAmountController.text) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      title: "Refill Credits",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select Amount", style: AppTextStyles.sectionLabel),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              childAspectRatio: 2.2,
            ),
            itemCount: _presetAmounts.length,
            itemBuilder: (_, index) {
              final isSelected = _selectedAmountIndex == index;
              return GestureDetector(
                onTap:
                    () => setState(() {
                      _selectedAmountIndex = index;
                      _customAmountController.clear();
                    }),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "\$${_presetAmounts[index].toInt()}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected
                                ? AppColors.white
                                : AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: _customAmountController,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() => _selectedAmountIndex = -1),
            decoration: InputDecoration(
              hintText: "Custom amount",
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13.sp),
              prefixIcon: Icon(
                Icons.attach_money,
                size: 18.sp,
                color: Colors.grey[400],
              ),
              filled: true,
              fillColor: AppColors.cardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text("Payment Method", style: AppTextStyles.sectionLabel),
          SizedBox(height: 10.h),
          ...List.generate(cards.length, (index) {
            final card = cards[index];
            return GestureDetector(
              onTap: () => setState(() => _selectedCardIndex = index),
              child: Container(
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color:
                        _selectedCardIndex == index
                            ? AppColors.primary
                            : AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.credit_card,
                      size: 20.sp,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.brand,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontSize: 13.sp,
                          ),
                        ),
                        Text(
                          "— ${card.lastFour}",
                          style: AppTextStyles.captionSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed:
                  _selectedAmount > 0
                      ? () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Refilled \$${_selectedAmount.toStringAsFixed(2)} successfully!",
                            ),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      }
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _selectedAmount > 0 ? AppColors.primary : Colors.grey[300],
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "Refill \$${_selectedAmount.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
