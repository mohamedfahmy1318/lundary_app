import 'package:json_annotation/json_annotation.dart';

part 'on_boarding_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OnBoardingModel {
  final int id;
  final String title;
  final String description;
  final String image;

  OnBoardingModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  factory OnBoardingModel.fromJson(Map<String, dynamic> json) => _$OnBoardingModelFromJson(json);
  Map<String, dynamic> toJson() => _$OnBoardingModelToJson(this);
}
