/// A lightweight item in the user's local cart.
/// Holds just enough data to display in the basket UI and send to the API.
class CartItem {
  final int serviceId;
  final String serviceName;
  final String categoryName;
  final double unitPrice;
  int quantity;

  CartItem({
    required this.serviceId,
    required this.serviceName,
    required this.categoryName,
    required this.unitPrice,
    this.quantity = 1,
  });

  double get totalPrice => unitPrice * quantity;

  /// Converts to the API payload shape for POST /orders
  Map<String, dynamic> toOrderJson() => {
        'service_id': serviceId,
        'quantity': quantity,
      };
}
