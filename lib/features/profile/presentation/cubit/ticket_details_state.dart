import 'package:laundry/features/profile/data/models/ticket_model.dart';

class TicketDetailsState {
  final bool isLoading;
  final bool isSendingReply;
  final bool isClosingTicket;
  final TicketModel? ticket;
  final String? errorMessage;
  final String? actionMessage;

  const TicketDetailsState({
    this.isLoading = false,
    this.isSendingReply = false,
    this.isClosingTicket = false,
    this.ticket,
    this.errorMessage,
    this.actionMessage,
  });

  factory TicketDetailsState.initial() => const TicketDetailsState();

  bool get hasTicket => ticket != null;

  TicketDetailsState copyWith({
    bool? isLoading,
    bool? isSendingReply,
    bool? isClosingTicket,
    TicketModel? ticket,
    bool clearTicket = false,
    String? errorMessage,
    bool clearError = false,
    String? actionMessage,
    bool clearActionMessage = false,
  }) {
    return TicketDetailsState(
      isLoading: isLoading ?? this.isLoading,
      isSendingReply: isSendingReply ?? this.isSendingReply,
      isClosingTicket: isClosingTicket ?? this.isClosingTicket,
      ticket: clearTicket ? null : (ticket ?? this.ticket),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      actionMessage: clearActionMessage
          ? null
          : (actionMessage ?? this.actionMessage),
    );
  }
}
