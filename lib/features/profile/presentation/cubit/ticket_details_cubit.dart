import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/profile/data/models/ticket_model.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';
import 'package:laundry/features/profile/presentation/cubit/ticket_details_state.dart';

class TicketDetailsCubit extends Cubit<TicketDetailsState> {
  final ProfileRepo _repo;

  TicketDetailsCubit({required ProfileRepo repo})
    : _repo = repo,
      super(TicketDetailsState.initial());

  Future<void> loadTicket(int ticketId) async {
    emit(
      state.copyWith(
        isLoading: true,
        clearError: true,
        clearActionMessage: true,
      ),
    );

    final result = await _repo.getTicketDetails(ticketId);
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (ticket) {
        emit(
          state.copyWith(
            isLoading: false,
            ticket: _sortTicketReplies(ticket),
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> sendReply(String message) async {
    final ticket = state.ticket;
    final trimmedMessage = message.trim();
    if (ticket == null || trimmedMessage.isEmpty || state.isSendingReply) {
      return;
    }

    final now = DateTime.now().toUtc().toIso8601String();
    final tempReplyId = -DateTime.now().microsecondsSinceEpoch;
    final optimisticReply = TicketReplyModel(
      id: tempReplyId,
      ticketId: ticket.id,
      userId: ticket.userId,
      message: trimmedMessage,
      isStaffReply: false,
      attachments: null,
      createdAt: now,
      updatedAt: now,
      user: _currentUserFromReplies(ticket.replies),
    );

    final optimisticReplies = _sortReplies([
      ...(ticket.replies ?? []),
      optimisticReply,
    ]);

    final optimisticTicket = _copyTicket(
      ticket,
      replies: optimisticReplies,
      updatedAt: now,
    );

    emit(
      state.copyWith(
        isSendingReply: true,
        ticket: optimisticTicket,
        clearError: true,
        clearActionMessage: true,
      ),
    );

    final result = await _repo.replyToTicket(
      ticketId: ticket.id,
      message: trimmedMessage,
    );

    result.fold(
      (failure) {
        final currentTicket = state.ticket;
        final rolledBackTicket =
            currentTicket == null
                ? ticket
                : _copyTicket(
                  currentTicket,
                  replies:
                      (currentTicket.replies ?? [])
                          .where((reply) => reply.id != tempReplyId)
                          .toList(),
                  updatedAt: ticket.updatedAt,
                );

        emit(
          state.copyWith(
            isSendingReply: false,
            ticket: _sortTicketReplies(rolledBackTicket),
            errorMessage: failure.message,
          ),
        );
      },
      (reply) {
        final currentTicket = state.ticket ?? optimisticTicket;
        final syncedReplies =
            (currentTicket.replies ?? [])
                .where((item) => item.id != tempReplyId)
                .toList();
        syncedReplies.add(reply);

        final updatedTicket = _copyTicket(
          currentTicket,
          replies: _sortReplies(syncedReplies),
          updatedAt: reply.updatedAt,
        );

        emit(
          state.copyWith(
            isSendingReply: false,
            ticket: _sortTicketReplies(updatedTicket),
            actionMessage: 'Reply sent successfully',
            clearError: true,
          ),
        );
      },
    );
  }

  Future<void> closeCurrentTicket() async {
    final ticket = state.ticket;
    if (ticket == null || ticket.isClosed || state.isClosingTicket) {
      return;
    }

    emit(
      state.copyWith(
        isClosingTicket: true,
        clearError: true,
        clearActionMessage: true,
      ),
    );

    final result = await _repo.closeTicket(ticket.id);
    result.fold(
      (failure) => emit(
        state.copyWith(isClosingTicket: false, errorMessage: failure.message),
      ),
      (updatedTicket) => emit(
        state.copyWith(
          isClosingTicket: false,
          ticket: _sortTicketReplies(updatedTicket),
          actionMessage: 'Ticket marked as closed',
          clearError: true,
        ),
      ),
    );
  }

  void clearMessages() {
    emit(state.copyWith(clearError: true, clearActionMessage: true));
  }

  TicketModel _copyTicket(
    TicketModel source, {
    List<TicketReplyModel>? replies,
    String? updatedAt,
  }) {
    return TicketModel(
      id: source.id,
      ticketNumber: source.ticketNumber,
      userId: source.userId,
      orderId: source.orderId,
      subject: source.subject,
      description: source.description,
      category: source.category,
      priority: source.priority,
      status: source.status,
      assignedTo: source.assignedTo,
      firstResponseAt: source.firstResponseAt,
      resolvedAt: source.resolvedAt,
      createdAt: source.createdAt,
      updatedAt: updatedAt ?? source.updatedAt,
      replies: replies ?? source.replies,
    );
  }

  TicketModel _sortTicketReplies(TicketModel ticket) {
    return _copyTicket(ticket, replies: _sortReplies(ticket.replies ?? []));
  }

  List<TicketReplyModel> _sortReplies(List<TicketReplyModel> replies) {
    final sorted = List<TicketReplyModel>.from(replies);
    sorted.sort(
      (a, b) => _parseDate(a.createdAt).compareTo(_parseDate(b.createdAt)),
    );
    return sorted;
  }

  DateTime _parseDate(String value) {
    return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  ReplyUserModel _currentUserFromReplies(List<TicketReplyModel>? replies) {
    if (replies == null) {
      return ReplyUserModel(id: 0, name: 'You', role: 'customer');
    }

    for (final reply in replies.reversed) {
      if (!reply.isStaffReply && reply.user != null) {
        return reply.user!;
      }
    }

    return ReplyUserModel(id: 0, name: 'You', role: 'customer');
  }
}
