// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
  id: (json['id'] as num).toInt(),
  categoryId: (json['category_id'] as num).toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String?,
  description: json['description'] as String?,
  price: json['price'] as String,
  expressPrice: json['express_price'] as String?,
  icon: json['icon'] as String?,
  image: json['image'] as String?,
  estimatedHours: (json['estimated_hours'] as num?)?.toInt(),
  sortOrder: (json['sort_order'] as num?)?.toInt(),
  isActive: json['is_active'] as bool?,
  category:
      json['category'] == null
          ? null
          : ServiceCategoryModel.fromJson(
            json['category'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'price': instance.price,
      'express_price': instance.expressPrice,
      'icon': instance.icon,
      'image': instance.image,
      'estimated_hours': instance.estimatedHours,
      'sort_order': instance.sortOrder,
      'is_active': instance.isActive,
      'category': instance.category,
    };

ServiceCategoryModel _$ServiceCategoryModelFromJson(
  Map<String, dynamic> json,
) => ServiceCategoryModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$ServiceCategoryModelToJson(
  ServiceCategoryModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
