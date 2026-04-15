import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/profile/domain/entities/ticket_entity.dart';

part 'ticket_details_state.freezed.dart';

@freezed
abstract class TicketDetailsState with _$TicketDetailsState {
  const TicketDetailsState._();

  const factory TicketDetailsState({
    @Default(false) bool isLoading,
    @Default(false) bool isSendingReply,
    @Default(false) bool isClosingTicket,
    TicketEntity? ticket,
    String? errorMessage,
    String? actionMessage,
  }) = _TicketDetailsState;
}
