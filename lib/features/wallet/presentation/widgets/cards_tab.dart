import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/bottom_sheet_wrapper.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../data/models/payment_card_model.dart';

class CardsTab extends StatefulWidget {
  const CardsTab({super.key});

  @override
  State<CardsTab> createState() => _CardsTabState();
}

class _CardsTabState extends State<CardsTab> {
  late List<PaymentCardModel> _cards;

  @override
  void initState() {
    super.initState();
    _cards = List.from(PaymentCardModel.mockCards);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add Card Button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 36.h,
              child: ElevatedButton.icon(
                onPressed: () => _showAddCardSheet(context),
                icon: Icon(Icons.add, size: 16.sp),
                label: Text(
                  "Add Card",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Cards List
        Expanded(
          child: _cards.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.credit_card_off,
                        size: 64.sp,
                        color: Colors.grey[300],
                      ),
                      SizedBox(height: 16.h),
                      Text("No cards saved", style: AppTextStyles.caption),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  itemCount: _cards.length,
                  itemBuilder: (_, index) {
                    final card = _cards[index];
                    return _CreditCardWidget(
                      card: card,
                      gradient: index == 0
                          ? const [Color(0xFF217AE6), Color(0xFF005CB2)]
                          : const [Color(0xFFFF6B35), Color(0xFFE53935)],
                      onRemove: () => setState(() => _cards.removeAt(index)),
                      onSetDefault: () {
                        setState(() {
                          _cards = _cards.map((c) {
                            return PaymentCardModel(
                              id: c.id,
                              brand: c.brand,
                              lastFour: c.lastFour,
                              cardholderName: c.cardholderName,
                              expiryDate: c.expiryDate,
                              isDefault: c.id == card.id,
                            );
                          }).toList();
                        });
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showAddCardSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddCardSheet(
        onAdd: (card) {
          setState(() => _cards.add(card));
        },
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Credit Card Widget
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class _CreditCardWidget extends StatelessWidget {
  final PaymentCardModel card;
  final List<Color> gradient;
  final VoidCallback onRemove;
  final VoidCallback onSetDefault;

  const _CreditCardWidget({
    required this.card,
    required this.gradient,
    required this.onRemove,
    required this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: gradient[0].withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Card Number",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  if (card.isDefault)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 12.sp,
                            color: AppColors.white,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "Default",
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                "•••• •••• •••• ${card.lastFour}",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 20.h),

              // Bottom Row
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cardholder",
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: AppColors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        card.cardholderName,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 32.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Expires",
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: AppColors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        card.expiryDate,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    card.brand,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Action Buttons
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!card.isDefault)
                TextButton(
                  onPressed: onSetDefault,
                  child: Text(
                    "Set as Default",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.primary,
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),
              TextButton.icon(
                onPressed: onRemove,
                icon: Icon(
                  Icons.delete_outline,
                  size: 16.sp,
                  color: AppColors.error,
                ),
                label: Text(
                  "Remove",
                  style: TextStyle(fontSize: 12.sp, color: AppColors.error),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Add Card Bottom Sheet
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class _AddCardSheet extends StatefulWidget {
  final ValueChanged<PaymentCardModel> onAdd;

  const _AddCardSheet({required this.onAdd});

  @override
  State<_AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<_AddCardSheet> {
  final _cardNumberController = TextEditingController();
  final _cardholderController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _cvvController = TextEditingController();
  String _selectedBrand = 'Visa';

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardholderController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      title: "Add Debit Card",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            // Card Brand
            Text("Card Brand", style: AppTextStyles.sectionLabel),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedBrand,
                  isExpanded: true,
                  items: ['Visa', 'Mastercard', 'Amex']
                      .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedBrand = val!),
                ),
              ),
            ),
            SizedBox(height: 14.h),

            // Card Number
            Text("Card Number", style: AppTextStyles.sectionLabel),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: _cardNumberController,
              hintText: "1234 5678 9012 3456",
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 14.h),

            // Cardholder Name
            Text("Cardholder Name", style: AppTextStyles.sectionLabel),
            SizedBox(height: 8.h),
            CustomTextField(
              controller: _cardholderController,
              hintText: "JOHN DOE",
            ),
            SizedBox(height: 14.h),

            // Month / Year / CVV
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Month", style: AppTextStyles.sectionLabel),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _monthController,
                        hintText: "MM",
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Year", style: AppTextStyles.sectionLabel),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _yearController,
                        hintText: "YYYY",
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("CVV", style: AppTextStyles.sectionLabel),
                      SizedBox(height: 8.h),
                      CustomTextField(
                        controller: _cvvController,
                        hintText: "123",
                        keyboardType: TextInputType.number,
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Add Card Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {
                  if (_cardNumberController.text.isNotEmpty &&
                      _cardholderController.text.isNotEmpty) {
                    final lastFour = _cardNumberController.text.length >= 4
                        ? _cardNumberController.text.substring(
                            _cardNumberController.text.length - 4,
                          )
                        : _cardNumberController.text;
                    widget.onAdd(
                      PaymentCardModel(
                        id: 'card_${DateTime.now().millisecondsSinceEpoch}',
                        brand: _selectedBrand,
                        lastFour: lastFour,
                        cardholderName: _cardholderController.text
                            .toUpperCase(),
                        expiryDate:
                            '${_monthController.text}/${_yearController.text}',
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Add Card",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      );
  }
}
