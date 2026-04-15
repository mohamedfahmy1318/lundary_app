import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/orders/data/models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(int id);
  Future<OrderModel> cancelOrder(int id);
  Future<OrderStatisticsModel> getStatistics();
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiClient _apiClient;

  OrdersRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await _apiClient.get(ApiConstants.orders);
    final payload = response.data;

    final data =
        payload is Map<String, dynamic>
            ? payload['data']
            : (payload is Map ? payload['data'] : payload);

    final records =
        data is Map<String, dynamic>
            ? data['data']
            : (data is Map ? data['data'] : data);

    final rawList = records is List ? records : const <dynamic>[];
    return rawList
        .whereType<Map>()
        .map((json) => OrderModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  @override
  Future<OrderModel> getOrderById(int id) async {
    final response = await _apiClient.get('${ApiConstants.orders}/$id');
    final data = _extractDataMap(response.data);
    return OrderModel.fromJson(data);
  }

  @override
  Future<OrderModel> cancelOrder(int id) async {
    final response = await _apiClient.post('${ApiConstants.orders}/$id/cancel');
    final data = _extractDataMap(response.data);
    return OrderModel.fromJson(data);
  }

  @override
  Future<OrderStatisticsModel> getStatistics() async {
    final response = await _apiClient.get('${ApiConstants.orders}/statistics');
    final data = _extractDataMap(response.data);
    return OrderStatisticsModel.fromJson(data);
  }

  Map<String, dynamic> _extractDataMap(Object? payload) {
    if (payload is Map<String, dynamic>) {
      final data = payload['data'];
      if (data is Map<String, dynamic>) {
        return data;
      }
      return payload;
    }
    if (payload is Map) {
      final mapPayload = Map<String, dynamic>.from(payload);
      final data = mapPayload['data'];
      if (data is Map) {
        return Map<String, dynamic>.from(data);
      }
      return mapPayload;
    }
    return const <String, dynamic>{};
  }
}
