import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/basket/data/models/time_slot_model.dart';

abstract class BasketRemoteDataSource {
  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData);
  Future<List<TimeSlotModel>> getTimeslots(String date);
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

  @override
  Future<List<TimeSlotModel>> getTimeslots(String date) async {
    final response = await _apiClient.get(
      ApiConstants.timeslots,
      queryParameters: {'date': date},
    );
    final List<dynamic> data = response.data['data'];
    return data
        .map((json) => TimeSlotModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
