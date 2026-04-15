import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/home/domain/entities/home_service_entity.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

@freezed
abstract class ServiceModel extends HomeServiceEntity with _$ServiceModel {
  const ServiceModel._();

  const factory ServiceModel({
    required int id,
    required int categoryId,
    required String name,
    String? slug,
    String? description,
    required String price,
    String? expressPrice,
    String? icon,
    String? image,
    int? estimatedHours,
    int? sortOrder,
    bool? isActive,
    ServiceCategoryModel? category,
  }) = _ServiceModel;

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(_normalizeJson(json));

  double get priceAsDouble => double.tryParse(price) ?? 0.0;
  double get expressPriceAsDouble => double.tryParse(expressPrice ?? '') ?? 0.0;

  static int? _parseInt(Object? value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value.toString());
  }

  static bool? _parseBool(Object? value) {
    if (value == null) {
      return null;
    }
    if (value is bool) {
      return value;
    }

    final normalized = value.toString().trim().toLowerCase();
    if (normalized == '1' || normalized == 'true') {
      return true;
    }
    if (normalized == '0' || normalized == 'false') {
      return false;
    }

    return null;
  }

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final categoryJson = json['category'] as Map<String, dynamic>?;

    return <String, dynamic>{
      ...json,
      'id': _parseInt(json['id']) ?? 0,
      'categoryId':
          _parseInt(json['category_id']) ?? _parseInt(categoryJson?['id']) ?? 0,
      'name': (json['name'] ?? '').toString(),
      'slug': json['slug']?.toString(),
      'description': json['description']?.toString(),
      'price': (json['price'] ?? '0').toString(),
      'expressPrice':
        (json['express_price'] ?? json['expressPrice'])?.toString(),
      'icon': json['icon']?.toString(),
      'image': json['image']?.toString(),
      'estimatedHours':
        _parseInt(json['estimated_hours'] ?? json['estimatedHours']),
      'sortOrder': _parseInt(json['sort_order'] ?? json['sortOrder'] ?? json['rank']),
      'isActive': _parseBool(json['is_active'] ?? json['isActive']),
      'category':
          categoryJson == null
              ? null
              : ServiceCategoryModel._normalizeJson(categoryJson),
    };
  }
}

@freezed
abstract class ServiceCategoryModel extends HomeServiceCategoryEntity
    with _$ServiceCategoryModel {
  const ServiceCategoryModel._();

  const factory ServiceCategoryModel({required int id, required String name}) =
      _ServiceCategoryModel;

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return <String, dynamic>{
      ...json,
      'id': ServiceModel._parseInt(json['id']) ?? 0,
      'name': (json['name'] ?? '').toString(),
    };
  }
}
