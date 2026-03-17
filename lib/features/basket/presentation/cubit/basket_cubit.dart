import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:laundry/features/basket/data/models/cart_item.dart';
import 'package:laundry/features/basket/domain/repos/basket_repo.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_state.dart';

class BasketCubit extends Cubit<BasketState> {
  final BasketRepo _basketRepo;

  BasketCubit({required BasketRepo basketRepo})
    : _basketRepo = basketRepo,
      super(const BasketState.initial());

  /// serviceId → CartItem
  final Map<int, CartItem> _cart = {};

  Map<int, CartItem> get cart => Map.unmodifiable(_cart);

  List<CartItem> get cartItems =>
      _cart.values.where((i) => i.quantity > 0).toList();

  double get totalAmount =>
      cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  int get totalItemsCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);

  int getQuantity(int serviceId) => _cart[serviceId]?.quantity ?? 0;

  List<CartItem> getItemsByCategory(String category) =>
      cartItems.where((i) => i.categoryName == category).toList();

  /// Add or increment a service in the cart.
  void addItem({
    required int serviceId,
    required String serviceName,
    required String categoryName,
    required double unitPrice,
  }) {
    if (_cart.containsKey(serviceId)) {
      _cart[serviceId]!.quantity++;
    } else {
      _cart[serviceId] = CartItem(
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
      item.quantity--;
      if (item.quantity == 0) _cart.remove(serviceId);
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
    required String paymentMethod,
    bool isExpress = false,
    String? promoCode,
    String? notes,
  }) async {
    if (cartItems.isEmpty) return;
    emit(const BasketState.orderCreating());

    final orderData = {
      'items': cartItems.map((i) => i.toOrderJson()).toList(),
      'pickup_date': pickupDate,
      'pickup_time_slot': pickupTimeSlot,
      'delivery_date': deliveryDate,
      'delivery_time_slot': deliveryTimeSlot,
      'pickup_address': pickupAddress,
      'payment_method': paymentMethod,
      'is_express': isExpress,
      if (promoCode != null && promoCode.isNotEmpty) 'promo_code': promoCode,
      if (notes != null && notes.isNotEmpty) 'notes': notes,
    };

    final result = await _basketRepo.createOrder(orderData);
    result.fold(
      (failure) => emit(BasketState.error(failure.message)),
      (_) {
        _cart.clear();
        emit(const BasketState.orderCreated());
      },
    );
  }

  void _emitLoaded() {
    emit(BasketState.loaded(cartItems));
  }
}
