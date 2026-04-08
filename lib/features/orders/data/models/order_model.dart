import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../core/constants/app_colors.dart';

part 'order_model.g.dart';

enum OrderStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('picking_up')
  pickingUp,
  @JsonValue('picked_up')
  pickedUp,
  @JsonValue('processing')
  processing,
  @JsonValue('ready')
  ready,
  @JsonValue('out_for_delivery')
  outForDelivery,
  @JsonValue('delivered')
  delivered,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

extension OrderStatusX on OrderStatus {
  String get uiName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.pickingUp:
        return 'Picking Up';
      case OrderStatus.pickedUp:
        return 'Picked Up';
      case OrderStatus.processing:
        return 'In Process';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

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
        return AppColors.success;
      case OrderStatus.completed:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.error;
    }
  }

  /// Maps each status to its representative icon.
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

  /// Returns true if this status represents an active/in-progress order.
  bool get isActive {
    switch (this) {
      case OrderStatus.pending:
      case OrderStatus.confirmed:
      case OrderStatus.pickingUp:
      case OrderStatus.pickedUp:
      case OrderStatus.processing:
      case OrderStatus.ready:
      case OrderStatus.outForDelivery:
        return true;
      case OrderStatus.delivered:
      case OrderStatus.completed:
      case OrderStatus.cancelled:
        return false;
    }
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderItemModel {
  final int id;
  final int orderId;
  final int serviceId;
  final String serviceName;
  final int quantity;
  final String unitPrice;
  final String totalPrice;
  final String? specialInstructions;

  const OrderItemModel({
    required this.id,
    required this.orderId,
    required this.serviceId,
    required this.serviceName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.specialInstructions,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  double get unitPriceAsDouble => double.tryParse(unitPrice) ?? 0.0;
  double get totalPriceAsDouble => double.tryParse(totalPrice) ?? 0.0;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderModel {
  final int id;
  final String orderNumber;
  final int userId;
  final OrderStatus status;
  final String? pickupDate;
  final String? pickupTimeSlot;
  final String? pickupAddress;
  final String? deliveryDate;
  final String? deliveryTimeSlot;
  final String? deliveryAddress;
  final String subtotal;
  final String deliveryFee;
  final String discountAmount;
  final String totalAmount;
  final String? paymentMethod;
  final String? paymentStatus;
  final String? notes;
  final String? promoCode;
  final bool isExpress;
  final String? cancelledAt;
  final String? cancellationReason;
  final String? createdAt;
  final String? updatedAt;
  final List<OrderItemModel>? items;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.userId,
    required this.status,
    this.pickupDate,
    this.pickupTimeSlot,
    this.pickupAddress,
    this.deliveryDate,
    this.deliveryTimeSlot,
    this.deliveryAddress,
    required this.subtotal,
    required this.deliveryFee,
    required this.discountAmount,
    required this.totalAmount,
    this.paymentMethod,
    this.paymentStatus,
    this.notes,
    this.promoCode,
    this.isExpress = false,
    this.cancelledAt,
    this.cancellationReason,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  double get totalAmountAsDouble => double.tryParse(totalAmount) ?? 0.0;

  int get itemsCount =>
      items?.fold(0, (sum, item) => sum! + item.quantity) ?? 0;

  DateTime? get pickupDateTime =>
      pickupDate != null ? DateTime.tryParse(pickupDate!) : null;

  DateTime? get deliveryDateTime =>
      deliveryDate != null ? DateTime.tryParse(deliveryDate!) : null;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderStatistics {
  final int totalOrders;
  final int pendingOrders;
  final int completedOrders;
  final int totalSpent;

  const OrderStatistics({
    required this.totalOrders,
    required this.pendingOrders,
    required this.completedOrders,
    required this.totalSpent,
  });

  factory OrderStatistics.fromJson(Map<String, dynamic> json) =>
      _$OrderStatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderStatisticsToJson(this);
}
