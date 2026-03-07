import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/profile/data/models/ticket_model.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded({
    required Map<String, dynamic> profile,
    required List<TicketModel> tickets,
    required List<Map<String, dynamic>> subscriptionPlans,
  }) = _Loaded;
  const factory ProfileState.error(String message) = _Error;
}
