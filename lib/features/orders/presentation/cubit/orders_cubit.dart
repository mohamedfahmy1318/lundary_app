import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:laundry/features/orders/domain/entities/order_entity.dart';
import 'package:laundry/features/orders/domain/entities/order_status.dart';
import 'package:laundry/features/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:laundry/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:laundry/features/orders/presentation/cubit/orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase _getOrdersUseCase;
  final CancelOrderUseCase _cancelOrderUseCase;

  OrdersCubit({
    required GetOrdersUseCase getOrdersUseCase,
    required CancelOrderUseCase cancelOrderUseCase,
  }) : _getOrdersUseCase = getOrdersUseCase,
       _cancelOrderUseCase = cancelOrderUseCase,
       super(const OrdersState.initial());

  List<OrderEntity> _allOrders = [];

  List<OrderEntity> get allOrders => _allOrders;

  List<OrderEntity> getFilteredOrders(OrderStatus? status) {
    if (status == null) return _allOrders;
    return _allOrders.where((o) => o.status == status).toList();
  }

  Future<void> getOrders() async {
    emit(const OrdersState.loading());
    final result = await _getOrdersUseCase();
    result.fold((failure) => emit(OrdersState.error(failure.message)), (
      orders,
    ) {
      _allOrders = orders;
      emit(OrdersState.loaded(orders));
    });
  }

  Future<void> cancelOrder(int orderId) async {
    emit(const OrdersState.loading());
    final result = await _cancelOrderUseCase(
      CancelOrderParams(orderId: orderId),
    );
    result.fold((failure) => emit(OrdersState.error(failure.message)), (
      cancelledOrder,
    ) {
      final index = _allOrders.indexWhere((o) => o.id == orderId);
      if (index != -1) {
        _allOrders[index] = cancelledOrder;
      }
      emit(OrdersState.loaded(List.from(_allOrders)));
    });
  }
}
