import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/home/domain/entities/home_category_entity.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel extends HomeCategoryEntity with _$CategoryModel {
  const CategoryModel._();

  const factory CategoryModel({
    required int id,
    required String name,
    String? description,
    String? icon,
    String? image,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
