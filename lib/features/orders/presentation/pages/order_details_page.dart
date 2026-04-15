import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/di/injection_container.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_order_by_id_usecase.dart';
import '../widgets/order_date_time_column.dart';
import '../widgets/order_item_row.dart';
import '../widgets/order_price_row.dart';
import '../widgets/order_status_stepper.dart';

class OrderDetailsPage extends StatefulWidget {
  final OrderEntity order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late OrderEntity _order;
  bool _isRefreshingDetails = false;
  String? _detailsErrorMessage;

  String _formatOrderDate(String? rawDate) {
    final value = rawDate?.trim();
    if (value == null || value.isEmpty) {
      return '-';
    }

    final parsed =
        AppFormatters.tryParse(value) ??
        AppFormatters.tryParse(value.replaceFirst(RegExp(r'z$'), 'Z'));
    if (parsed != null) {
      return AppFormatters.formatDate(parsed.toLocal(), pattern: 'dd MMM yyyy');
    }

    final datePart = value.split('T').first;
    final parts = datePart.split('-');
    if (parts.length == 3) {
      final year = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final day = int.tryParse(parts[2]);
      if (year != null && month != null && day != null) {
        return AppFormatters.formatDate(
          DateTime(year, month, day),
          pattern: 'dd MMM yyyy',
        );
      }
    }

    return datePart;
  }

  @override
  void initState() {
    super.initState();
    _order = widget.order;
    _loadOrderDetails(
      showLoader: _order.items == null || _order.items!.isEmpty,
    );
  }

  Future<void> _loadOrderDetails({bool showLoader = true}) async {
    if (showLoader) {
      setState(() {
        _isRefreshingDetails = true;
        _detailsErrorMessage = null;
      });
    }

    final result = await getIt<GetOrderByIdUseCase>()(
      GetOrderByIdParams(orderId: _order.id),
    );
    if (!mounted) {
      return;
    }

    result.fold(
      (failure) {
        setState(() {
          _isRefreshingDetails = false;
          _detailsErrorMessage = failure.message;
        });
      },
      (freshOrder) {
        setState(() {
          _order = freshOrder;
          _isRefreshingDetails = false;
          _detailsErrorMessage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isRefreshingDetails && _order.items == null) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBarFactory.build(
          context,
          title: "Order Details",
          showBack: true,
          onBack: () => Navigator.pop(context),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(
        context,
        title: "Order Details",
        showBack: true,
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_detailsErrorMessage != null) ...[
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 14.h),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(20),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _detailsErrorMessage!,
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _loadOrderDetails,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ],
            Text("Order #${_order.orderNumber}", style: AppTextStyles.caption),
            SizedBox(height: 20.h),

            // Basket Summary
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Basket", style: AppTextStyles.sectionTitle),
                          Text(
                            '${_order.itemsCount} items',
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OrderDateTimeColumn(
                          label: 'Pickup',
                          date: _formatOrderDate(_order.pickupDate),
                          time: _order.pickupTimeSlot ?? '-',
                        ),
                      ),
                      Expanded(
                        child: OrderDateTimeColumn(
                          label: 'Delivery',
                          date: _formatOrderDate(_order.deliveryDate),
                          time: _order.deliveryTimeSlot ?? '-',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Status Stepper
            OrderStatusStepper(status: _order.status),

            SizedBox(height: 30.h),

            // Items List
            if (_order.items != null && _order.items!.isNotEmpty)
              ..._order.items!.map((item) => OrderItemRow(item: item))
            else
              const Center(child: Text("No detailed items for this order")),

            SizedBox(height: 20.h),

            // Price Summary
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  OrderPriceRow(label: 'Subtotal', value: _order.subtotal),
                  SizedBox(height: 8.h),
                  OrderPriceRow(
                    label: 'Delivery Fee',
                    value: _order.deliveryFee,
                  ),
                  if (double.tryParse(_order.discountAmount) != 0.0) ...[
                    SizedBox(height: 8.h),
                    OrderPriceRow(
                      label: 'Discount',
                      value: '-${_order.discountAmount}',
                      valueColor: Colors.green,
                    ),
                  ],
                  Divider(height: 24.h),
                  OrderPriceRow(
                    label: 'Total',
                    value: _order.totalAmount,
                    isBold: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}
