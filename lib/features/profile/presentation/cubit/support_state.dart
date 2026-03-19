import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/profile/data/models/ticket_model.dart';

part 'support_state.freezed.dart';

@freezed
class SupportState with _$SupportState {
  const factory SupportState.initial() = _Initial;
  const factory SupportState.loading() = _Loading;
  const factory SupportState.loaded({
    required List<TicketModel> tickets,
  }) = _Loaded;
  const factory SupportState.submitting() = _Submitting;
  const factory SupportState.submissionSuccess() = _SubmissionSuccess;
  const factory SupportState.error(String message) = _Error;
}
