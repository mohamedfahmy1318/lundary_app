import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/home/data/models/category_model.dart';
import 'package:laundry/features/home/data/models/service_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<ServiceModel>> getServices({int? categoryId, String? search});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient _apiClient;

  HomeRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _apiClient.get(ApiConstants.categories);
    final List<dynamic> data = response.data['data'];
    return data
        .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ServiceModel>> getServices({
    int? categoryId,
    String? search,
  }) async {
    final queryParams = <String, dynamic>{};
    if (categoryId != null) queryParams['category_id'] = categoryId;
    if (search != null && search.isNotEmpty) queryParams['search'] = search;

    final response = await _apiClient.get(
      ApiConstants.services,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
    final List<dynamic> data = response.data['data'];
    return data
        .map((json) => ServiceModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
