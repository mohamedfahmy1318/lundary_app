import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/network/api_client.dart';

abstract class BasketRemoteDataSource {
  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData);
}

class BasketRemoteDataSourceImpl implements BasketRemoteDataSource {
  final ApiClient _apiClient;

  BasketRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<Map<String, dynamic>> createOrder(
    Map<String, dynamic> orderData,
  ) async {
    final response = await _apiClient.post(
      ApiConstants.orders,
      data: orderData,
    );
    return response.data as Map<String, dynamic>;
  }
}
