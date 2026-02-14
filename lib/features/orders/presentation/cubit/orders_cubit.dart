import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:laundry/features/orders/data/models/order_model.dart';
import 'package:laundry/features/orders/domain/repos/orders_repo.dart';
import 'package:laundry/features/orders/presentation/cubit/orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepo _ordersRepo;

  OrdersCubit({required OrdersRepo ordersRepo})
    : _ordersRepo = ordersRepo,
      super(const OrdersState.initial());

  List<OrderModel> _allOrders = [];

  List<OrderModel> get allOrders => _allOrders;

  List<OrderModel> getFilteredOrders(OrderStatus? status) {
    if (status == null) return _allOrders;
    return _allOrders.where((o) => o.status == status).toList();
  }

  Future<void> getOrders() async {
    emit(const OrdersState.loading());
    final result = await _ordersRepo.getOrders();
    result.fold((failure) => emit(OrdersState.error(failure.message)), (
      orders,
    ) {
      _allOrders = orders;
      emit(OrdersState.loaded(orders));
    });
  }
}
