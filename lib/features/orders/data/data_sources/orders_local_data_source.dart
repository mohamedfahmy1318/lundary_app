import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/features/orders/data/models/order_model.dart';

abstract class OrdersLocalDataSource {
  Future<void> cacheOrders(List<OrderModel> orders);
  Future<List<OrderModel>> getCachedOrders();

  Future<void> cacheOrder(OrderModel order);
  Future<OrderModel> getCachedOrderById(int orderId);

  Future<void> cacheStatistics(OrderStatisticsModel statistics);
  Future<OrderStatisticsModel> getCachedStatistics();
}

class OrdersLocalDataSourceImpl implements OrdersLocalDataSource {
  List<OrderModel> _cachedOrders = const <OrderModel>[];
  final Map<int, OrderModel> _cachedOrdersById = <int, OrderModel>{};
  OrderStatisticsModel? _cachedStatistics;

  @override
  Future<void> cacheOrders(List<OrderModel> orders) async {
    _cachedOrders = List<OrderModel>.unmodifiable(orders);
    _cachedOrdersById
      ..clear()
      ..addEntries(orders.map((order) => MapEntry(order.id, order)));
  }

  @override
  Future<List<OrderModel>> getCachedOrders() async {
    if (_cachedOrders.isEmpty) {
      throw const CacheException(message: 'No cached orders found.');
    }
    return _cachedOrders;
  }

  @override
  Future<void> cacheOrder(OrderModel order) async {
    _cachedOrdersById[order.id] = order;

    final existingIndex = _cachedOrders.indexWhere((o) => o.id == order.id);
    if (existingIndex == -1) {
      _cachedOrders = List<OrderModel>.unmodifiable(<OrderModel>[
        order,
        ..._cachedOrders,
      ]);
      return;
    }

    final updated = List<OrderModel>.from(_cachedOrders);
    updated[existingIndex] = order;
    _cachedOrders = List<OrderModel>.unmodifiable(updated);
  }

  @override
  Future<OrderModel> getCachedOrderById(int orderId) async {
    final cached = _cachedOrdersById[orderId];
    if (cached == null) {
      throw const CacheException(message: 'No cached order details found.');
    }
    return cached;
  }

  @override
  Future<void> cacheStatistics(OrderStatisticsModel statistics) async {
    _cachedStatistics = statistics;
  }

  @override
  Future<OrderStatisticsModel> getCachedStatistics() async {
    final cached = _cachedStatistics;
    if (cached == null) {
      throw const CacheException(message: 'No cached order statistics found.');
    }
    return cached;
  }
}
