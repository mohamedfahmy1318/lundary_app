abstract class OrderItemEntity {
  const OrderItemEntity();

  int get id;
  int get orderId;
  int get serviceId;
  String get serviceName;
  int get quantity;
  String get unitPrice;
  String get totalPrice;
  String? get specialInstructions;

  double get unitPriceAsDouble => double.tryParse(unitPrice) ?? 0.0;
  double get totalPriceAsDouble => double.tryParse(totalPrice) ?? 0.0;
}
