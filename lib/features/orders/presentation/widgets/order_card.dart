import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/order_model.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  // Layout constants
  static const double _cardBorderRadius = 30;
  static const double _statusIconSize = 40;
  static const double _arrowIconSize = 20;
  static const double _statusInnerIconSize = 24;
  static const double _verticalMargin = 8;
  static const double _horizontalPadding = 16;
  static const double _verticalPadding = 16;
  static const double _iconTextSpacing = 12;
  static const double _subtitleTopSpacing = 4;

  // Currency constant — update here if the app goes multi-currency
  static const String _currencyPrefix = 'AED';

  const OrderCard({super.key, required this.order, required this.onTap});

  /// Formats the summary line shown below the order number.
  String get _summaryText =>
      '$_currencyPrefix ${order.totalAmount}  ·  ${order.itemsCount} '
      '${order.itemsCount == 1 ? 'item' : 'items'}';

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          'Order ${order.orderNumber}, '
          'status: ${order.status.uiName}, '
          '$_summaryText',
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: _verticalMargin.h),
          padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding.w,
            vertical: _verticalPadding.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(_cardBorderRadius.r),
          ),
          child: Row(
            children: [
              _StatusIcon(status: order.status),
              SizedBox(width: _iconTextSpacing.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _OrderHeaderRow(order: order),
                    SizedBox(height: _subtitleTopSpacing.h),
                    Text(_summaryText, style: AppTextStyles.caption),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.textPrimary,
                size: _arrowIconSize.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Private sub-widgets
// ---------------------------------------------------------------------------

/// Circular icon that reflects the current order status.
class _StatusIcon extends StatelessWidget {
  final OrderStatus status;

  const _StatusIcon({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: OrderCard._statusIconSize.w,
      height: OrderCard._statusIconSize.w,
      decoration: BoxDecoration(color: status.uiColor, shape: BoxShape.circle),
      child: Icon(
        status.uiIcon, // uses the new extension getter
        color: AppColors.white,
        size: OrderCard._statusInnerIconSize.sp,
      ),
    );
  }
}

/// Row that shows order number (left) and status badge (right).
class _OrderHeaderRow extends StatelessWidget {
  final OrderModel order;

  const _OrderHeaderRow({required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(order.orderNumber, style: AppTextStyles.bodyMedium),
        _StatusBadge(status: order.status),
      ],
    );
  }
}

/// Small coloured text label showing the status name.
class _StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Text(
      status.uiName,
      style: AppTextStyles.caption.copyWith(
        color: status.uiColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
