import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/onboarding/domain/entities/on_boarding_slide_entity.dart';

part 'on_boarding_model.freezed.dart';
part 'on_boarding_model.g.dart';

@freezed
abstract class OnBoardingModel extends OnBoardingSlideEntity
    with _$OnBoardingModel {
  const OnBoardingModel._();

  const factory OnBoardingModel({
    required int id,
    required String title,
    required String description,
    required String? image,
  }) = _OnBoardingModel;

  factory OnBoardingModel.fromJson(Map<String, dynamic> json) =>
      _$OnBoardingModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return <String, dynamic>{
      ...json,
      'id': _parseInt(json['id']) ?? 0,
      'title': (json['title'] ?? '').toString(),
      'description': (json['description'] ?? '').toString(),
      'image': _parseNullableString(json['image']),
    };
  }

  static int? _parseInt(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '');
  }

  static String? _parseNullableString(Object? value) {
    final text = value?.toString().trim();
    if (text == null || text.isEmpty || text.toLowerCase() == 'null') {
      return null;
    }
    return text;
  }
}
