// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimeSlotModel _$TimeSlotModelFromJson(Map<String, dynamic> json) =>
    _TimeSlotModel(
      id: json['id'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      type: json['type'] as String,
      maxOrders: json['max_orders'] as String,
      availableDays: json['available_days'] as String,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$TimeSlotModelToJson(_TimeSlotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'type': instance.type,
      'max_orders': instance.maxOrders,
      'available_days': instance.availableDays,
      'is_active': instance.isActive,
    };
