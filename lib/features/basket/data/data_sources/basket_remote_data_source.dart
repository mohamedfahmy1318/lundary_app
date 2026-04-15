import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/basket/data/models/create_order_models.dart';
import 'package:laundry/features/basket/data/models/time_slot_model.dart';

abstract class BasketRemoteDataSource {
  Future<CreateOrderResponseModel> createOrder(
    CreateOrderRequestModel orderData,
  );
  Future<List<TimeSlotModel>> getTimeslots(String date);
}

class BasketRemoteDataSourceImpl implements BasketRemoteDataSource {
  final ApiClient _apiClient;

  BasketRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<CreateOrderResponseModel> createOrder(
    CreateOrderRequestModel orderData,
  ) async {
    final response = await _apiClient.post(
      ApiConstants.orders,
      data: orderData.toApiJson(),
    );
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return CreateOrderResponseModel.fromJson(data);
    }
    if (data is Map) {
      return CreateOrderResponseModel.fromJson(Map<String, dynamic>.from(data));
    }
    return const CreateOrderResponseModel(
      success: false,
      message: 'Invalid create-order response format.',
    );
  }

  @override
  Future<List<TimeSlotModel>> getTimeslots(String date) async {
    final response = await _apiClient.get(
      ApiConstants.timeslots,
      queryParameters: {'date': date},
    );
    final responseData = response.data;
    final source =
        responseData is Map<String, dynamic>
            ? responseData['data']
            : (responseData is Map ? responseData['data'] : responseData);

    final List<dynamic> data = source is List ? source : const <dynamic>[];
    return data
        .whereType<Map>()
        .map((json) => TimeSlotModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }
}
