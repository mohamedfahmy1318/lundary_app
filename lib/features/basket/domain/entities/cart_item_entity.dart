import 'package:equatable/equatable.dart';

abstract class CartItemEntity {
  const CartItemEntity();

  int get serviceId;
  String get serviceName;
  String get categoryName;
  double get unitPrice;
  int get quantity;

  double get totalPrice => unitPrice * quantity;
}

class BasketCartItemEntity extends CartItemEntity with EquatableMixin {
  final int serviceId;
  final String serviceName;
  final String categoryName;
  final double unitPrice;
  final int quantity;

  const BasketCartItemEntity({
    required this.serviceId,
    required this.serviceName,
    required this.categoryName,
    required this.unitPrice,
    this.quantity = 1,
  });

  BasketCartItemEntity copyWith({
    int? serviceId,
    String? serviceName,
    String? categoryName,
    double? unitPrice,
    int? quantity,
  }) {
    return BasketCartItemEntity(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      categoryName: categoryName ?? this.categoryName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [
    serviceId,
    serviceName,
    categoryName,
    unitPrice,
    quantity,
  ];
}
