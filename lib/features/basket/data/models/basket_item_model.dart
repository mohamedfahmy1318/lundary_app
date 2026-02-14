class BasketItemModel {
  final String id;
  final String name;
  final String category; // 'Washing', 'Dry Cleaning', 'Ironing'
  final double price;
  int quantity;

  BasketItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.quantity = 0,
  });

  factory BasketItemModel.fromJson(Map<String, dynamic> json) {
    return BasketItemModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'quantity': quantity,
    };
  }

  // Mock data for initial state
  static List<BasketItemModel> get mockItems => [
    BasketItemModel(id: '1', name: 'Shirt', category: 'Washing', price: 10.0),
    BasketItemModel(id: '2', name: 'T-Shirt', category: 'Washing', price: 8.0),
    BasketItemModel(id: '3', name: 'Pants', category: 'Washing', price: 12.0),
    BasketItemModel(
      id: '4',
      name: 'Dress',
      category: 'Dry Cleaning',
      price: 25.0,
    ),
    BasketItemModel(
      id: '5',
      name: 'Suit',
      category: 'Dry Cleaning',
      price: 40.0,
    ),
    BasketItemModel(
      id: '6',
      name: 'Abaya',
      category: 'Dry Cleaning',
      price: 30.0,
    ),
    BasketItemModel(
      id: '7',
      name: 'Thobe',
      category: 'Dry Cleaning',
      price: 20.0,
    ),
    BasketItemModel(id: '8', name: 'Shirt', category: 'Ironing', price: 5.0),
    BasketItemModel(id: '9', name: 'Pants', category: 'Ironing', price: 6.0),
  ];
}
