import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/basket/data/models/time_slot_model.dart';

part 'timeslots_state.freezed.dart';

@freezed
abstract class TimeslotsState with _$TimeslotsState {
  const factory TimeslotsState.initial() = _Initial;
  const factory TimeslotsState.loading() = _Loading;
  const factory TimeslotsState.loaded(List<TimeSlotModel> timeSlots) = _Loaded;
  const factory TimeslotsState.error(String message) = _Error;
}
