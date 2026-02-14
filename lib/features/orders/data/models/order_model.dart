enum OrderStatus { completed, inProgress, deliveryOnTheWay, cancelled }

class OrderItem {
  final String name;
  final double price;
  final int quantity;

  OrderItem({required this.name, required this.price, required this.quantity});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'quantity': quantity};
  }
}

class OrderModel {
  final String id;
  final String locationName;
  final DateTime pickupDate;
  final DateTime deliveryDate;
  final OrderStatus status;
  final List<OrderItem> items;
  final String basketItemsCount;
  final double totalAmount;

  OrderModel({
    required this.id,
    required this.locationName,
    required this.pickupDate,
    required this.deliveryDate,
    required this.status,
    required this.items,
    required this.basketItemsCount,
    required this.totalAmount,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id']?.toString() ?? '',
      locationName: json['location_name'] as String? ?? '',
      pickupDate: json['pickup_date'] != null
          ? DateTime.parse(json['pickup_date'] as String)
          : DateTime.now(),
      deliveryDate: json['delivery_date'] != null
          ? DateTime.parse(json['delivery_date'] as String)
          : DateTime.now(),
      status: _parseStatus(json['status'] as String?),
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      basketItemsCount: json['basket_items_count'] as String? ?? '',
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location_name': locationName,
      'pickup_date': pickupDate.toIso8601String(),
      'delivery_date': deliveryDate.toIso8601String(),
      'status': status.name,
      'items': items.map((e) => e.toJson()).toList(),
      'basket_items_count': basketItemsCount,
      'total_amount': totalAmount,
    };
  }

  static OrderStatus _parseStatus(String? status) {
    switch (status) {
      case 'completed':
        return OrderStatus.completed;
      case 'in_progress':
        return OrderStatus.inProgress;
      case 'delivery_on_the_way':
        return OrderStatus.deliveryOnTheWay;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.inProgress;
    }
  }

  static List<OrderModel> mockOrders = [
    OrderModel(
      id: "#22456",
      locationName: "Home 1",
      pickupDate: DateTime(2025, 7, 20),
      deliveryDate: DateTime(2025, 7, 22),
      status: OrderStatus.deliveryOnTheWay,
      basketItemsCount: "23 Items in total",
      totalAmount: 240.0,
      items: [
        OrderItem(name: "Suit", price: 30.00, quantity: 1),
        OrderItem(name: "Suit", price: 30.00, quantity: 1),
        OrderItem(name: "Suit", price: 30.00, quantity: 1),
        OrderItem(name: "Suit", price: 30.00, quantity: 1),
        OrderItem(name: "Suit", price: 30.00, quantity: 1),
        OrderItem(name: "Suit", price: 30.00, quantity: 1),
        OrderItem(name: "Suit", price: 30.00, quantity: 1),
        OrderItem(name: "Suit", price: 30.00, quantity: 1),
      ],
    ),
    OrderModel(
      id: "#22455",
      locationName: "Home 1",
      pickupDate: DateTime(2025, 7, 18),
      deliveryDate: DateTime(2025, 7, 20),
      status: OrderStatus.completed,
      basketItemsCount: "10 Items in total",
      totalAmount: 150.0,
      items: [OrderItem(name: "Shirt", price: 15.00, quantity: 10)],
    ),
    OrderModel(
      id: "#22454",
      locationName: "Home 1",
      pickupDate: DateTime(2025, 7, 15),
      deliveryDate: DateTime(2025, 7, 17),
      status: OrderStatus.completed,
      basketItemsCount: "5 Items in total",
      totalAmount: 75.0,
      items: [],
    ),
    OrderModel(
      id: "#22453",
      locationName: "Office",
      pickupDate: DateTime(2025, 7, 10),
      deliveryDate: DateTime(2025, 7, 12),
      status: OrderStatus.completed,
      basketItemsCount: "2 Items in total",
      totalAmount: 30.0,
      items: [],
    ),
    OrderModel(
      id: "#22452",
      locationName: "Home 1",
      pickupDate: DateTime(2025, 7, 5),
      deliveryDate: DateTime(2025, 7, 7),
      status: OrderStatus.completed,
      basketItemsCount: "1 Items in total",
      totalAmount: 15.0,
      items: [],
    ),
  ];
}
