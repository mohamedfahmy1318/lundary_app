// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) =>
    _ServiceModel(
      id: (json['id'] as num).toInt(),
      categoryId: (json['categoryId'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String,
      expressPrice: json['expressPrice'] as String?,
      icon: json['icon'] as String?,
      image: json['image'] as String?,
      estimatedHours: (json['estimatedHours'] as num?)?.toInt(),
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      category:
          json['category'] == null
              ? null
              : ServiceCategoryModel.fromJson(
                json['category'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$ServiceModelToJson(_ServiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'price': instance.price,
      'expressPrice': instance.expressPrice,
      'icon': instance.icon,
      'image': instance.image,
      'estimatedHours': instance.estimatedHours,
      'sortOrder': instance.sortOrder,
      'isActive': instance.isActive,
      'category': instance.category,
    };

_ServiceCategoryModel _$ServiceCategoryModelFromJson(
  Map<String, dynamic> json,
) => _ServiceCategoryModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$ServiceCategoryModelToJson(
  _ServiceCategoryModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
