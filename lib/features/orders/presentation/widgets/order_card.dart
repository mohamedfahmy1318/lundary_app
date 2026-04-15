import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_status.dart';
import '../utils/order_status_ui_x.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;
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

  const OrderCard({super.key, required this.order, required this.onTap});

  String get _itemsText =>
      '${order.itemsCount} '
      '${order.itemsCount == 1 ? 'item' : 'items'}';

  String get _amountText => order.totalAmount;

  String get _summarySemanticsText => '$_amountText  ·  $_itemsText';

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          'Order ${order.orderNumber}, '
          'status: ${order.status.uiName}, '
          '$_summarySemanticsText',
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
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/icon_price.png',
                          width: 12.w,
                          height: 12.w,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            '$_amountText  ·  $_itemsText',
                            style: AppTextStyles.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
  final OrderEntity order;

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
