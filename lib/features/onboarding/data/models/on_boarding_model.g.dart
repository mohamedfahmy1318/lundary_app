// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'on_boarding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnBoardingModel _$OnBoardingModelFromJson(Map<String, dynamic> json) =>
    _OnBoardingModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$OnBoardingModelToJson(_OnBoardingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
    };
