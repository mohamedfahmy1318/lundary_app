import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/bottom_sheet_wrapper.dart';
import '../../data/models/wallet_transaction_model.dart';
import '../../data/models/payment_card_model.dart';

class WalletTab extends StatelessWidget {
  const WalletTab({super.key});

  @override
  Widget build(BuildContext context) {
    final double balance = 250.00;
    final transactions = WalletTransactionModel.mockTransactions;

    return Column(
      children: [
        // Balance Card
        _BalanceCard(
          balance: balance,
          onRefill: () => _showRefillSheet(context),
        ),

        SizedBox(height: 16.h),

        // Recent Transactions
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Recent Transactions",
              style: AppTextStyles.sectionTitle,
            ),
          ),
        ),
        SizedBox(height: 12.h),

        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            itemCount: transactions.length,
            separatorBuilder: (_, _) =>
                Divider(height: 1, color: AppColors.divider),
            itemBuilder: (_, index) =>
                _TransactionTile(transaction: transactions[index]),
          ),
        ),
      ],
    );
  }

  void _showRefillSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _RefillCreditsSheet(),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Balance Card
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class _BalanceCard extends StatelessWidget {
  final double balance;
  final VoidCallback onRefill;

  const _BalanceCard({required this.balance, required this.onRefill});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                size: 16.sp,
                color: AppColors.white.withValues(alpha: 0.8),
              ),
              SizedBox(width: 6.w),
              Text(
                "Total Balance",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            "D ${balance.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Available Credits",
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 36.h,
            child: ElevatedButton.icon(
              onPressed: onRefill,
              icon: Icon(Icons.add, size: 16.sp),
              label: Text(
                "Refill Credits",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Transaction Tile
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class _TransactionTile extends StatelessWidget {
  final WalletTransactionModel transaction;

  const _TransactionTile({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.isCredit;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: (isCredit ? AppColors.success : AppColors.error)
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: isCredit ? AppColors.success : AppColors.error,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),

          // Title + Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.title, style: AppTextStyles.bodyMedium),
                SizedBox(height: 2.h),
                Text(
                  _formatDate(transaction.date),
                  style: AppTextStyles.captionSmall,
                ),
              ],
            ),
          ),

          // Amount
          Text(
            "${isCredit ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isCredit ? AppColors.success : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[date.month - 1]} ${date.day}, ${date.year}";
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// Refill Credits Bottom Sheet
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class _RefillCreditsSheet extends StatefulWidget {
  const _RefillCreditsSheet();

  @override
  State<_RefillCreditsSheet> createState() => _RefillCreditsSheetState();
}

class _RefillCreditsSheetState extends State<_RefillCreditsSheet> {
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
          // Select Amount
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
                onTap: () => setState(() {
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
                        color: isSelected
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

          // Custom amount
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

          // Payment Method
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
                    color: _selectedCardIndex == index
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

          // Refill Button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: _selectedAmount > 0
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
                backgroundColor: _selectedAmount > 0
                    ? AppColors.primary
                    : Colors.grey[300],
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
