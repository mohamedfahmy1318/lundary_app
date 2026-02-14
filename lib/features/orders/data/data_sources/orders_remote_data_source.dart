import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/orders/data/models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> getOrderById(String id);
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  // ignore: unused_field
  final ApiClient _apiClient;

  OrdersRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<OrderModel>> getOrders() async {
    // TODO: Replace with actual API endpoint
    // final response = await _apiClient.get('/orders');
    // final List<dynamic> data = response.data['data'];
    // return data.map((json) => OrderModel.fromJson(json)).toList();
    return OrderModel.mockOrders;
  }

  @override
  Future<OrderModel> getOrderById(String id) async {
    // TODO: Replace with actual API endpoint
    // final response = await _apiClient.get('/orders/$id');
    // return OrderModel.fromJson(response.data['data']);
    return OrderModel.mockOrders.firstWhere((o) => o.id == id);
  }
}
