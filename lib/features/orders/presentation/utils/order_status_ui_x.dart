import 'package:flutter/material.dart';

import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/features/orders/domain/entities/order_status.dart';

extension OrderStatusUiX on OrderStatus {
  String get uiName => displayName;

  Color get uiColor {
    switch (this) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.confirmed:
        return Colors.blue;
      case OrderStatus.pickingUp:
        return Colors.indigo;
      case OrderStatus.pickedUp:
        return Colors.deepPurple;
      case OrderStatus.processing:
        return Colors.purple;
      case OrderStatus.ready:
        return Colors.teal;
      case OrderStatus.outForDelivery:
        return Colors.orangeAccent;
      case OrderStatus.delivered:
      case OrderStatus.completed:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.error;
    }
  }

  IconData get uiIcon {
    switch (this) {
      case OrderStatus.pending:
        return Icons.schedule;
      case OrderStatus.confirmed:
      case OrderStatus.pickingUp:
      case OrderStatus.pickedUp:
      case OrderStatus.processing:
      case OrderStatus.ready:
        return Icons.sync;
      case OrderStatus.outForDelivery:
        return Icons.local_shipping;
      case OrderStatus.delivered:
      case OrderStatus.completed:
        return Icons.check_circle_outline;
      case OrderStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }
}
