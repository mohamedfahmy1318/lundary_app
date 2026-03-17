import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/basket_cubit.dart';
import '../cubit/basket_state.dart';
import '../widgets/detail_row.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/payment_method_tile.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, String>? scheduleData;

  const PaymentPage({super.key, this.scheduleData});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedPaymentMethod = 0;
  final TextEditingController _promoController = TextEditingController();

  final List<String> _paymentMethods = ['cash', 'card', 'wallet'];

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final basketCubit = getIt<BasketCubit>();
    final pickupDate = widget.scheduleData?['pickupDate'] ?? '-';
    final pickupTimeSlot = widget.scheduleData?['pickupTimeSlot'] ?? '-';
    final deliveryDate = widget.scheduleData?['deliveryDate'] ?? '-';
    final deliveryTimeSlot = widget.scheduleData?['deliveryTimeSlot'] ?? '-';

    return BlocProvider.value(
      value: basketCubit,
      child: BlocListener<BasketCubit, BasketState>(
        listener: (context, state) {
          state.maybeWhen(
            orderCreated: () => context.pushNamed('orderSuccess'),
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          backgroundColor: AppColors.cardBackground,
          appBar: AppBarFactory.build(
            context,
            title: "Payment",
            backgroundColor: AppColors.cardBackground,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderSummaryCard(
                        title: "Basket",
                        itemCount:
                            "${basketCubit.totalItemsCount} Items in total",
                        pickupDate: pickupDate,
                        pickupTime: pickupTimeSlot,
                        deliveryDate: deliveryDate,
                        deliveryTime: deliveryTimeSlot,
                      ),
                      SizedBox(height: 24.h),

                      // Promo Code
                      Text("Promo Code", style: AppTextStyles.sectionTitle),
                      SizedBox(height: 12.h),
                      TextField(
                        controller: _promoController,
                        decoration: InputDecoration(
                          hintText: "Enter promo code...",
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 13.sp,
                          ),
                          filled: true,
                          fillColor: AppColors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.r),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Total Detail
                      Text("Total Detail", style: AppTextStyles.sectionTitle),
                      SizedBox(height: 12.h),
                      DetailRow(
                        label: "Price:",
                        value:
                            "AED ${basketCubit.totalAmount.toStringAsFixed(2)}",
                      ),
                      SizedBox(height: 8.h),
                      const DetailRow(
                        label: "Subscription Balance",
                        value: "50 Item(s) Remaining",
                      ),
                      SizedBox(height: 8.h),
                      const DetailRow(label: "Promo Code:", value: "-"),
                      SizedBox(height: 24.h),

                      // Payment Method
                      Text("Payment Method", style: AppTextStyles.sectionTitle),
                      SizedBox(height: 12.h),

                      Row(
                        children: [
                          Expanded(
                            child: PaymentMethodTile(
                              icon: Icons.attach_money,
                              label: "Cash",
                              isSelected: _selectedPaymentMethod == 0,
                              onTap:
                                  () => setState(
                                    () => _selectedPaymentMethod = 0,
                                  ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.sync, size: 18),
                            label: const Text("Use Balance"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                              foregroundColor: AppColors.white,
                              minimumSize: Size(0, 48.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      PaymentMethodTile(
                        icon: Icons.credit_card,
                        label: "Card",
                        isSelected: _selectedPaymentMethod == 1,
                        onTap: () => setState(() => _selectedPaymentMethod = 1),
                      ),
                      SizedBox(height: 12.h),
                      PaymentMethodTile(
                        icon: Icons.account_balance_wallet,
                        label: "E-Wallet",
                        isSelected: _selectedPaymentMethod == 2,
                        onTap: () => setState(() => _selectedPaymentMethod = 2),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),

              // Pay Now Button
              BlocBuilder<BasketCubit, BasketState>(
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    orderCreating: () => true,
                    orElse: () => false,
                  );
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 20.h,
                    ),
                    child: CustomButton(
                      text: isLoading ? "Processing..." : "Pay Now",
                      onPressed:
                          isLoading
                              ? null
                              : () {
                                basketCubit.createOrder(
                                  pickupDate: pickupDate,
                                  pickupTimeSlot: pickupTimeSlot,
                                  deliveryDate: deliveryDate,
                                  deliveryTimeSlot: deliveryTimeSlot,
                                  pickupAddress: 'Test Address, Dubai, UAE',
                                  paymentMethod:
                                      _paymentMethods[_selectedPaymentMethod],
                                  promoCode:
                                      _promoController.text.isNotEmpty
                                          ? _promoController.text
                                          : null,
                                );
                              },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
