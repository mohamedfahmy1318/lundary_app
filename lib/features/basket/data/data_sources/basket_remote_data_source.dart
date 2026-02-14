import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/basket/data/models/basket_item_model.dart';

abstract class BasketRemoteDataSource {
  Future<List<BasketItemModel>> getServices();
  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData);
}

class BasketRemoteDataSourceImpl implements BasketRemoteDataSource {
  // ignore: unused_field
  final ApiClient _apiClient;

  BasketRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<BasketItemModel>> getServices() async {
    // TODO: Replace with actual API endpoint
    // final response = await _apiClient.get('/services');
    // final List<dynamic> data = response.data['data'];
    // return data.map((json) => BasketItemModel.fromJson(json)).toList();
    return BasketItemModel.mockItems;
  }

  @override
  Future<Map<String, dynamic>> createOrder(
    Map<String, dynamic> orderData,
  ) async {
    // TODO: Replace with actual API endpoint
    // final response = await _apiClient.post('/orders', data: orderData);
    // return response.data;
    return {'id': '#00001', 'status': 'success'};
  }
}
