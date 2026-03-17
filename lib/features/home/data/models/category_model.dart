import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoryModel {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final String? image;

  const CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
