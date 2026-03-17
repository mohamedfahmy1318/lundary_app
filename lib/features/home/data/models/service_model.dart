import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ServiceModel {
  final int id;
  final int categoryId;
  final String name;
  final String? slug;
  final String? description;
  final String price;
  final String? expressPrice;
  final String? icon;
  final String? image;
  final int? estimatedHours;
  final int? sortOrder;
  final bool? isActive;
  final ServiceCategoryModel? category;

  const ServiceModel({
    required this.id,
    required this.categoryId,
    required this.name,
    this.slug,
    this.description,
    required this.price,
    this.expressPrice,
    this.icon,
    this.image,
    this.estimatedHours,
    this.sortOrder,
    this.isActive,
    this.category,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);

  double get priceAsDouble => double.tryParse(price) ?? 0.0;
  double get expressPriceAsDouble =>
      double.tryParse(expressPrice ?? '') ?? 0.0;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ServiceCategoryModel {
  final int id;
  final String name;

  const ServiceCategoryModel({required this.id, required this.name});

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCategoryModelToJson(this);
}
