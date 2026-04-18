import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:laundry/features/basket/domain/entities/cart_item_entity.dart';
import 'package:laundry/features/basket/domain/entities/payment_status_entity.dart';
import 'package:laundry/features/basket/domain/usecases/create_order_usecase.dart';
import 'package:laundry/features/basket/domain/usecases/get_order_payment_status_usecase.dart';
import 'package:laundry/features/basket/domain/usecases/initiate_order_payment_usecase.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_state.dart';

class BasketCubit extends Cubit<BasketState> {
  final CreateOrderUseCase _createOrderUseCase;
  final InitiateOrderPaymentUseCase _initiateOrderPaymentUseCase;
  final GetOrderPaymentStatusUseCase _getOrderPaymentStatusUseCase;

  int? _pendingPaymentOrderId;
  String? _pendingPaymentOrderNumber;

  BasketCubit({
    required CreateOrderUseCase createOrderUseCase,
    required InitiateOrderPaymentUseCase initiateOrderPaymentUseCase,
    required GetOrderPaymentStatusUseCase getOrderPaymentStatusUseCase,
  }) : _createOrderUseCase = createOrderUseCase,
       _initiateOrderPaymentUseCase = initiateOrderPaymentUseCase,
       _getOrderPaymentStatusUseCase = getOrderPaymentStatusUseCase,
       super(const BasketState.initial());

  /// serviceId -> cart item
  final Map<int, BasketCartItemEntity> _cart = {};

  Map<int, BasketCartItemEntity> get cart => Map.unmodifiable(_cart);
  bool get hasPendingPaymentOrder => _pendingPaymentOrderId != null;

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

    await result.fold(
      (failure) async => emit(BasketState.error(failure.message)),
      (response) async {
        final orderId = response.orderId;
        final orderNumber = response.orderNumber;

        if (orderId == null) {
          emit(
            const BasketState.error(
              'Order created but order id is missing in response.',
            ),
          );
          return;
        }

        final normalizedPaymentMethod = paymentMethod.trim().toLowerCase();
        if (normalizedPaymentMethod != 'card') {
          _clearPendingPaymentOrder();
          _cart.clear();
          emit(
            BasketState.orderCreated(
              orderId: orderId,
              orderNumber: orderNumber,
            ),
          );
          return;
        }

        _setPendingPaymentOrder(orderId: orderId, orderNumber: orderNumber);
        _cart.clear();
        await _initiatePaymentForOrder(
          orderId: orderId,
          orderNumber: orderNumber,
          emitLoadingState: false,
        );
      },
    );
  }

  Future<void> retryPendingOrderPayment() async {
    final orderId = _pendingPaymentOrderId;
    if (orderId == null) {
      emit(
        const BasketState.error('No pending order found to retry payment for.'),
      );
      return;
    }

    await _initiatePaymentForOrder(
      orderId: orderId,
      orderNumber: _pendingPaymentOrderNumber,
      emitLoadingState: true,
    );
  }

  Future<void> confirmOrderPayment({
    required int orderId,
    String? orderNumber,
    int maxAttempts = 8,
    Duration interval = const Duration(seconds: 2),
  }) async {
    emit(const BasketState.paymentVerifying());

    String? lastError;
    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final statusResult = await _getOrderPaymentStatusUseCase(
        GetOrderPaymentStatusParams(orderId: orderId),
      );

      final isPaid = statusResult.fold(
        (failure) {
          lastError = failure.message;
          return false;
        },
        (status) {
          if (_isPaymentSuccessful(status)) {
            return true;
          }
          lastError = _buildPendingPaymentMessage(status);
          return false;
        },
      );

      if (isPaid) {
        _clearPendingPaymentOrder();
        _cart.clear();
        emit(
          BasketState.orderCreated(orderId: orderId, orderNumber: orderNumber),
        );
        return;
      }

      final shouldRetry = attempt < maxAttempts - 1;
      if (shouldRetry) {
        await Future<void>.delayed(interval);
      }
    }

    emit(
      BasketState.paymentFailed(
        lastError ??
            'Payment is not confirmed yet. Please check your orders shortly.',
      ),
    );
  }

  bool _isPaymentSuccessful(PaymentStatusEntity status) {
    if (status.paid) {
      return true;
    }

    final paymentStatus = _normalizeStatus(status.paymentStatus);
    final orderStatus = _normalizeStatus(status.orderStatus);

    const successfulPaymentStatuses = <String>{
      'paid',
      'success',
      'successful',
      'authorized',
      'captured',
      'completed',
    };

    const successfulOrderStatuses = <String>{
      'paid',
      'confirmed',
      'processing',
      'completed',
    };

    return successfulPaymentStatuses.contains(paymentStatus) ||
        successfulOrderStatuses.contains(orderStatus);
  }

  String _buildPendingPaymentMessage(PaymentStatusEntity status) {
    final paymentStatus = _normalizeStatus(status.paymentStatus);
    final orderStatus = _normalizeStatus(status.orderStatus);

    if (paymentStatus.isNotEmpty) {
      return 'Payment status is $paymentStatus. Waiting for confirmation.';
    }
    if (orderStatus.isNotEmpty) {
      return 'Order status is $orderStatus. Waiting for payment confirmation.';
    }
    return 'Waiting for payment confirmation from server.';
  }

  String _normalizeStatus(String? value) {
    if (value == null) {
      return '';
    }
    return value.trim().toLowerCase();
  }

  Future<void> _initiatePaymentForOrder({
    required int orderId,
    String? orderNumber,
    required bool emitLoadingState,
  }) async {
    if (emitLoadingState) {
      emit(const BasketState.orderCreating());
    }

    final paymentResult = await _initiateOrderPaymentUseCase(
      InitiateOrderPaymentParams(orderId: orderId),
    );

    paymentResult.fold(
      (failure) => emit(
        BasketState.orderPaymentInitiationFailed(
          orderId: orderId,
          orderNumber: orderNumber,
          message: failure.message,
        ),
      ),
      (payment) => emit(
        BasketState.orderPaymentRequired(
          orderId: orderId,
          orderNumber: orderNumber,
          paymentUrl: payment.paymentUrl,
        ),
      ),
    );
  }

  void _setPendingPaymentOrder({required int orderId, String? orderNumber}) {
    _pendingPaymentOrderId = orderId;
    _pendingPaymentOrderNumber = orderNumber;
  }

  void _clearPendingPaymentOrder() {
    _pendingPaymentOrderId = null;
    _pendingPaymentOrderNumber = null;
  }

  void _emitLoaded() {
    emit(BasketState.loaded(cartItems));
  }
}
