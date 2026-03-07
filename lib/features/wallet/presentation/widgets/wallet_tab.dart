import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/wallet_transaction_model.dart';
import 'balance_card.dart';
import 'refill_credits_sheet.dart';
import 'transaction_tile.dart';

class WalletTab extends StatelessWidget {
  const WalletTab({super.key});

  @override
  Widget build(BuildContext context) {
    final double balance = 250.00;
    final transactions = WalletTransactionModel.mockTransactions;

    return Column(
      children: [
        BalanceCard(
          balance: balance,
          onRefill: () => _showRefillSheet(context),
        ),
        SizedBox(height: 16.h),
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
            separatorBuilder:
                (_, __) => Divider(height: 1, color: AppColors.divider),
            itemBuilder:
                (_, index) => TransactionTile(transaction: transactions[index]),
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
      builder: (_) => const RefillCreditsSheet(),
    );
  }
}
