import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/basket/domain/entities/time_slot_entity.dart';

part 'time_slot_model.freezed.dart';
part 'time_slot_model.g.dart';

@freezed
abstract class TimeSlotModel extends TimeSlotEntity with _$TimeSlotModel {
  const TimeSlotModel._();

  const factory TimeSlotModel({
    required String id,
    @JsonKey(name: 'start_time') required String startTime,
    @JsonKey(name: 'end_time') required String endTime,
    required String type,
    @JsonKey(name: 'max_orders') required String maxOrders,
    @JsonKey(name: 'available_days') required String availableDays,
    @JsonKey(name: 'is_active') required bool isActive,
  }) = _TimeSlotModel;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return <String, dynamic>{
      ...json,
      'id': (json['id'] ?? '').toString(),
      'start_time': (json['start_time'] ?? json['startTime'] ?? '').toString(),
      'end_time': (json['end_time'] ?? json['endTime'] ?? '').toString(),
      'type': (json['type'] ?? '').toString(),
      'max_orders': (json['max_orders'] ?? json['maxOrders'] ?? '').toString(),
      'available_days': _parseAvailableDays(
        json['available_days'] ?? json['availableDays'],
      ),
      'is_active': _parseBool(json['is_active'] ?? json['isActive']),
    };
  }

  static String _parseAvailableDays(Object? value) {
    if (value == null) {
      return '';
    }
    if (value is String) {
      return value;
    }
    if (value is Iterable) {
      return value.map((day) => day.toString()).join(',');
    }
    return value.toString();
  }

  static bool _parseBool(Object? value) {
    if (value is bool) {
      return value;
    }
    final normalized = value?.toString().trim().toLowerCase();
    return normalized == '1' || normalized == 'true';
  }
}
