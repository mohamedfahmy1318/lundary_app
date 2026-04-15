import 'package:laundry/features/orders/domain/entities/order_item_entity.dart';
import 'package:laundry/features/orders/domain/entities/order_status.dart';

abstract class OrderEntity {
  const OrderEntity();

  int get id;
  String get orderNumber;
  int get userId;
  OrderStatus get status;
  String? get pickupDate;
  String? get pickupTimeSlot;
  String? get pickupAddress;
  String? get deliveryDate;
  String? get deliveryTimeSlot;
  String? get deliveryAddress;
  String get subtotal;
  String get deliveryFee;
  String get discountAmount;
  String get totalAmount;
  String? get paymentMethod;
  String? get paymentStatus;
  String? get notes;
  String? get promoCode;
  bool get isExpress;
  String? get cancelledAt;
  String? get cancellationReason;
  String? get createdAt;
  String? get updatedAt;
  List<OrderItemEntity>? get items;

  double get totalAmountAsDouble => double.tryParse(totalAmount) ?? 0.0;

  int get itemsCount =>
      items?.fold<int>(0, (sum, item) => sum + item.quantity) ?? 0;

  DateTime? get pickupDateTime =>
      pickupDate != null ? DateTime.tryParse(pickupDate!) : null;

  DateTime? get deliveryDateTime =>
      deliveryDate != null ? DateTime.tryParse(deliveryDate!) : null;
}
