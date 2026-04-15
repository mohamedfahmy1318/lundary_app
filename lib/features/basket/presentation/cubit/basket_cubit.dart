import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:laundry/features/basket/domain/entities/cart_item_entity.dart';
import 'package:laundry/features/basket/domain/usecases/create_order_usecase.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_state.dart';

class BasketCubit extends Cubit<BasketState> {
  final CreateOrderUseCase _createOrderUseCase;

  BasketCubit({required CreateOrderUseCase createOrderUseCase})
    : _createOrderUseCase = createOrderUseCase,
      super(const BasketState.initial());

  /// serviceId -> cart item
  final Map<int, BasketCartItemEntity> _cart = {};

  Map<int, BasketCartItemEntity> get cart => Map.unmodifiable(_cart);

  List<CartItemEntity> get cartItems =>
      _cart.values.where((i) => i.quantity > 0).toList();

  double get totalAmount =>
      cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  int get totalItemsCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  int getQuantity(int serviceId) => _cart[serviceId]?.quantity ?? 0;

  List<CartItemEntity> getItemsByCategory(String category) =>
      cartItems.where((i) => i.categoryName == category).toList();

  /// Add or increment a service in the cart.
  void addItem({
    required int serviceId,
    required String serviceName,
    required String categoryName,
    required double unitPrice,
  }) {
    if (_cart.containsKey(serviceId)) {
      final existing = _cart[serviceId]!;
      _cart[serviceId] = existing.copyWith(quantity: existing.quantity + 1);
    } else {
      _cart[serviceId] = BasketCartItemEntity(
        serviceId: serviceId,
        serviceName: serviceName,
        categoryName: categoryName,
        unitPrice: unitPrice,
      );
    }
    _emitLoaded();
  }

  void decrementItem(int serviceId) {
    final item = _cart[serviceId];
    if (item != null && item.quantity > 0) {
      final newQty = item.quantity - 1;
      if (newQty == 0) {
        _cart.remove(serviceId);
      } else {
        _cart[serviceId] = item.copyWith(quantity: newQty);
      }
      _emitLoaded();
    }
  }

  void removeItem(int serviceId) {
    _cart.remove(serviceId);
    _emitLoaded();
  }

  void clearCart() {
    _cart.clear();
    _emitLoaded();
  }

  /// Send the order to the API.
  Future<void> createOrder({
    required String pickupDate,
    required String pickupTimeSlot,
    required String deliveryDate,
    required String deliveryTimeSlot,
    required String pickupAddress,
    required String deliveryAddress,
    required String paymentMethod,
    bool isExpress = false,
    String? promoCode,
    String? notesPickup,
    String? notesDelivery,
  }) async {
    if (cartItems.isEmpty) return;
    emit(const BasketState.orderCreating());

    final result = await _createOrderUseCase(
      CreateOrderParams(
        items: cartItems,
        pickupDate: pickupDate,
        pickupTimeSlot: pickupTimeSlot,
        deliveryDate: deliveryDate,
        deliveryTimeSlot: deliveryTimeSlot,
        pickupAddress: pickupAddress,
        deliveryAddress: deliveryAddress,
        paymentMethod: paymentMethod,
        isExpress: isExpress,
        promoCode: promoCode,
        notesPickup: notesPickup,
        notesDelivery: notesDelivery,
      ),
    );
    result.fold((failure) => emit(BasketState.error(failure.message)), (_) {
      _cart.clear();
      emit(const BasketState.orderCreated());
    });
  }

  void _emitLoaded() {
    emit(BasketState.loaded(cartItems));
  }
}
