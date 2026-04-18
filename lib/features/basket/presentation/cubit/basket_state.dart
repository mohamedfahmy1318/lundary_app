import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:laundry/features/basket/domain/entities/cart_item_entity.dart';

part 'basket_state.freezed.dart';

@freezed
class BasketState with _$BasketState {
  const factory BasketState.initial() = _Initial;
  const factory BasketState.loading() = _Loading;
  const factory BasketState.loaded(List<CartItemEntity> items) = _Loaded;
  const factory BasketState.orderCreating() = _OrderCreating;
  const factory BasketState.orderPaymentRequired({
    required int orderId,
    String? orderNumber,
    required String paymentUrl,
  }) = _OrderPaymentRequired;
  const factory BasketState.orderPaymentInitiationFailed({
    required int orderId,
    String? orderNumber,
    required String message,
  }) = _OrderPaymentInitiationFailed;
  const factory BasketState.paymentVerifying() = _PaymentVerifying;
  const factory BasketState.orderCreated({int? orderId, String? orderNumber}) =
      _OrderCreated;
  const factory BasketState.paymentFailed(String message) = _PaymentFailed;
  const factory BasketState.error(String message) = _Error;
}
