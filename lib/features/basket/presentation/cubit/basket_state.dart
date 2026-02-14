import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:laundry/features/basket/data/models/basket_item_model.dart';

part 'basket_state.freezed.dart';

@freezed
class BasketState with _$BasketState {
  const factory BasketState.initial() = _Initial;
  const factory BasketState.loading() = _Loading;
  const factory BasketState.loaded(List<BasketItemModel> items) = _Loaded;
  const factory BasketState.orderCreating() = _OrderCreating;
  const factory BasketState.orderCreated() = _OrderCreated;
  const factory BasketState.error(String message) = _Error;
}
