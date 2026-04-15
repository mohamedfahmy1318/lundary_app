import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/features/home/data/models/banner_model.dart';
import 'package:laundry/features/home/data/models/category_model.dart';
import 'package:laundry/features/home/data/models/service_model.dart';

abstract class HomeLocalDataSource {
  Future<void> cacheCategories(List<CategoryModel> categories);
  Future<List<CategoryModel>> getCachedCategories();

  Future<void> cacheBanners(List<BannerModel> banners);
  Future<List<BannerModel>> getCachedBanners();

  Future<void> cacheServices(
    List<ServiceModel> services, {
    int? categoryId,
    String? search,
  });
  Future<List<ServiceModel>> getCachedServices({
    int? categoryId,
    String? search,
  });

  Future<void> cacheTopServices(
    List<ServiceModel> services, {
    required String period,
    required int limit,
  });
  Future<List<ServiceModel>> getCachedTopServices({
    required String period,
    required int limit,
  });
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  List<CategoryModel> _cachedCategories = const [];
  List<BannerModel> _cachedBanners = const [];
  final Map<String, List<ServiceModel>> _cachedServicesByQuery =
      <String, List<ServiceModel>>{};
  final Map<String, List<ServiceModel>> _cachedTopServicesByQuery =
      <String, List<ServiceModel>>{};

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    _cachedCategories = List<CategoryModel>.unmodifiable(categories);
  }

  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    if (_cachedCategories.isEmpty) {
      throw const CacheException(message: 'No cached home categories found.');
    }
    return _cachedCategories;
  }

  @override
  Future<void> cacheBanners(List<BannerModel> banners) async {
    _cachedBanners = List<BannerModel>.unmodifiable(banners);
  }

  @override
  Future<List<BannerModel>> getCachedBanners() async {
    if (_cachedBanners.isEmpty) {
      throw const CacheException(message: 'No cached home banners found.');
    }
    return _cachedBanners;
  }

  @override
  Future<void> cacheServices(
    List<ServiceModel> services, {
    int? categoryId,
    String? search,
  }) async {
    _cachedServicesByQuery[_servicesCacheKey(
      categoryId,
      search,
    )] = List<ServiceModel>.unmodifiable(services);
  }

  @override
  Future<List<ServiceModel>> getCachedServices({
    int? categoryId,
    String? search,
  }) async {
    final cached =
        _cachedServicesByQuery[_servicesCacheKey(categoryId, search)];
    if (cached == null || cached.isEmpty) {
      throw const CacheException(message: 'No cached services found.');
    }
    return cached;
  }

  @override
  Future<void> cacheTopServices(
    List<ServiceModel> services, {
    required String period,
    required int limit,
  }) async {
    _cachedTopServicesByQuery[_topServicesCacheKey(
      period,
      limit,
    )] = List<ServiceModel>.unmodifiable(services);
  }

  @override
  Future<List<ServiceModel>> getCachedTopServices({
    required String period,
    required int limit,
  }) async {
    final cached =
        _cachedTopServicesByQuery[_topServicesCacheKey(period, limit)];
    if (cached == null || cached.isEmpty) {
      throw const CacheException(message: 'No cached top services found.');
    }
    return cached;
  }

  String _servicesCacheKey(int? categoryId, String? search) {
    final normalizedSearch = (search ?? '').trim().toLowerCase();
    return 'category_${categoryId ?? 'all'}_search_$normalizedSearch';
  }

  String _topServicesCacheKey(String period, int limit) {
    final normalizedPeriod = period.trim().toLowerCase();
    return 'period_${normalizedPeriod}_limit_$limit';
  }
}
