abstract class OrderResponseEntity {
  const OrderResponseEntity();

  bool get success;
  String get message;
  int? get orderId;
  String? get orderNumber;
}
