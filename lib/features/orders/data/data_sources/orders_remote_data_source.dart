import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/orders/data/models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(int id);
  Future<OrderModel> cancelOrder(int id);
  Future<OrderStatistics> getStatistics();
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final ApiClient _apiClient;

  OrdersRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<OrderModel>> getOrders() async {
    final response = await _apiClient.get(ApiConstants.orders);
    final paginated = response.data['data'] as Map<String, dynamic>;
    final List<dynamic> data = paginated['data'] as List<dynamic>;
    return data
        .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<OrderModel> getOrderById(int id) async {
    final response = await _apiClient.get('${ApiConstants.orders}/$id');
    return OrderModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<OrderModel> cancelOrder(int id) async {
    final response = await _apiClient.post('${ApiConstants.orders}/$id/cancel');
    return OrderModel.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<OrderStatistics> getStatistics() async {
    final response = await _apiClient.get('${ApiConstants.orders}/statistics');
    return OrderStatistics.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }
}
