import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_slot_model.freezed.dart';
part 'time_slot_model.g.dart';

@freezed
abstract class TimeSlotModel with _$TimeSlotModel {
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
      _$TimeSlotModelFromJson(json);
}
