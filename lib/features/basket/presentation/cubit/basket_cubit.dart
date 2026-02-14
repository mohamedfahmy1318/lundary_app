import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:laundry/features/basket/data/models/basket_item_model.dart';
import 'package:laundry/features/basket/domain/repos/basket_repo.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_state.dart';

class BasketCubit extends Cubit<BasketState> {
  final BasketRepo _basketRepo;

  BasketCubit({required BasketRepo basketRepo})
    : _basketRepo = basketRepo,
      super(const BasketState.initial());

  List<BasketItemModel> _items = [];
  DateTime? selectedPickupDate;
  int? selectedPickupSlot;
  DateTime? selectedDeliveryDate;
  int? selectedDeliverySlot;
  String pickupNote = '';
  String deliveryNote = '';
  int selectedPaymentMethod = 0;
  String promoCode = '';

  List<BasketItemModel> get items => _items;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get totalItemsCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  List<BasketItemModel> getItemsByCategory(String category) {
    return _items.where((item) => item.category == category).toList();
  }

  Future<void> loadServices() async {
    emit(const BasketState.loading());
    final result = await _basketRepo.getServices();
    result.fold((failure) => emit(BasketState.error(failure.message)), (items) {
      _items = items;
      emit(BasketState.loaded(List.from(_items)));
    });
  }

  void incrementItem(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _items[index].quantity++;
      emit(BasketState.loaded(List.from(_items)));
    }
  }

  void decrementItem(String itemId) {
    final index = _items.indexWhere((item) => item.id == itemId);
    if (index != -1 && _items[index].quantity > 0) {
      _items[index].quantity--;
      emit(BasketState.loaded(List.from(_items)));
    }
  }

  void setPickupSchedule(DateTime date, int slotIndex, String note) {
    selectedPickupDate = date;
    selectedPickupSlot = slotIndex;
    pickupNote = note;
  }

  void setDeliverySchedule(DateTime date, int slotIndex, String note) {
    selectedDeliveryDate = date;
    selectedDeliverySlot = slotIndex;
    deliveryNote = note;
  }

  void setPaymentMethod(int index) {
    selectedPaymentMethod = index;
  }

  void setPromoCode(String code) {
    promoCode = code;
  }

  Future<void> createOrder() async {
    emit(const BasketState.orderCreating());

    final orderData = {
      'items': _items
          .where((item) => item.quantity > 0)
          .map((item) => item.toJson())
          .toList(),
      'pickup_date': selectedPickupDate?.toIso8601String(),
      'pickup_slot': selectedPickupSlot,
      'pickup_note': pickupNote,
      'delivery_date': selectedDeliveryDate?.toIso8601String(),
      'delivery_slot': selectedDeliverySlot,
      'delivery_note': deliveryNote,
      'payment_method': selectedPaymentMethod,
      'promo_code': promoCode,
      'total_amount': totalAmount,
    };

    final result = await _basketRepo.createOrder(orderData);
    result.fold((failure) => emit(BasketState.error(failure.message)), (_) {
      _resetOrder();
      emit(const BasketState.orderCreated());
    });
  }

  void _resetOrder() {
    for (final item in _items) {
      item.quantity = 0;
    }
    selectedPickupDate = null;
    selectedPickupSlot = null;
    selectedDeliveryDate = null;
    selectedDeliverySlot = null;
    pickupNote = '';
    deliveryNote = '';
    selectedPaymentMethod = 0;
    promoCode = '';
  }
}
