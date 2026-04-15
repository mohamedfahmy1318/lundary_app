import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/home/data/models/category_model.dart';
import 'package:laundry/features/home/data/models/service_model.dart';
import 'package:laundry/features/home/data/models/banner_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<ServiceModel>> getServices({int? categoryId, String? search});
  Future<List<ServiceModel>> getTopServices({String period, int limit});
  Future<List<BannerModel>> getBanners();
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

  @override
  Future<List<ServiceModel>> getTopServices({
    String period = 'all',
    int limit = 10,
  }) async {
    final response = await _apiClient.get(
      ApiConstants.topServices,
      queryParameters: {'period': period, 'limit': limit},
    );

    final List<dynamic> data = response.data['data'] as List<dynamic>;
    return data
        .map((json) => _mapTopService(json as Map<String, dynamic>))
        .toList();
  }

  ServiceModel _mapTopService(Map<String, dynamic> json) {
    final categoryJson = json['category'] as Map<String, dynamic>?;

    return ServiceModel(
      id: (json['id'] as num).toInt(),
      categoryId: ((categoryJson?['id'] as num?)?.toInt()) ?? 0,
      name: (json['name'] as String?) ?? '',
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      price: (json['price'] ?? '0').toString(),
      expressPrice: json['express_price']?.toString(),
      icon: json['icon'] as String?,
      image: json['image'] as String?,
      estimatedHours: (json['estimated_hours'] as num?)?.toInt(),
      sortOrder: (json['rank'] as num?)?.toInt(),
      isActive: json['is_active'] as bool?,
      category:
          categoryJson == null
              ? null
              : ServiceCategoryModel(
                id: ((categoryJson['id'] as num?)?.toInt()) ?? 0,
                name: (categoryJson['name'] as String?) ?? '',
              ),
    );
  }

  @override
  Future<List<BannerModel>> getBanners() async {
    final response = await _apiClient.get(ApiConstants.banners);
    final List<dynamic> data = response.data['data'];
    return data
        .map((json) => BannerModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
