import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:laundry/features/basket/domain/entities/cart_item_entity.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
abstract class CartItemModel extends CartItemEntity with _$CartItemModel {
  const CartItemModel._();

  const factory CartItemModel({
    required int serviceId,
    required String serviceName,
    required String categoryName,
    required double unitPrice,
    @Default(1) int quantity,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      serviceId: entity.serviceId,
      serviceName: entity.serviceName,
      categoryName: entity.categoryName,
      unitPrice: entity.unitPrice,
      quantity: entity.quantity,
    );
  }

  BasketCartItemEntity toEntity() {
    return BasketCartItemEntity(
      serviceId: serviceId,
      serviceName: serviceName,
      categoryName: categoryName,
      unitPrice: unitPrice,
      quantity: quantity,
    );
  }

  Map<String, dynamic> toOrderJson() => {
    'service_id': serviceId,
    'quantity': quantity,
  };
}
