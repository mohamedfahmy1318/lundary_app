import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/profile/domain/entities/ticket_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_reply_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_reply_user_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_status.dart';
import 'package:laundry/features/profile/domain/usecases/close_ticket_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_ticket_details_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/reply_to_ticket_usecase.dart';
import 'package:laundry/features/profile/presentation/cubit/ticket_details_state.dart';

class TicketDetailsCubit extends Cubit<TicketDetailsState> {
  final GetTicketDetailsUseCase _getTicketDetailsUseCase;
  final ReplyToTicketUseCase _replyToTicketUseCase;
  final CloseTicketUseCase _closeTicketUseCase;

  TicketDetailsCubit({
    required GetTicketDetailsUseCase getTicketDetailsUseCase,
    required ReplyToTicketUseCase replyToTicketUseCase,
    required CloseTicketUseCase closeTicketUseCase,
  }) : _getTicketDetailsUseCase = getTicketDetailsUseCase,
       _replyToTicketUseCase = replyToTicketUseCase,
       _closeTicketUseCase = closeTicketUseCase,
       super(const TicketDetailsState());

  Future<void> loadTicket(int ticketId) async {
    emit(
      state.copyWith(isLoading: true, errorMessage: null, actionMessage: null),
    );

    final result = await _getTicketDetailsUseCase(
      GetTicketDetailsParams(ticketId: ticketId),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
          actionMessage: null,
        ),
      ),
      (ticket) {
        emit(
          state.copyWith(
            isLoading: false,
            ticket: _sortTicketReplies(ticket),
            errorMessage: null,
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

    final optimisticReply = _TicketReplySnapshot(
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

    final optimisticReplies = _sortReplies(<TicketReplyEntity>[
      ...(ticket.replies ?? const <TicketReplyEntity>[]),
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
        errorMessage: null,
        actionMessage: null,
      ),
    );

    final result = await _replyToTicketUseCase(
      ReplyToTicketParams(ticketId: ticket.id, message: trimmedMessage),
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
                      (currentTicket.replies ?? const <TicketReplyEntity>[])
                          .where((reply) => reply.id != tempReplyId)
                          .toList(),
                  updatedAt: ticket.updatedAt,
                );

        emit(
          state.copyWith(
            isSendingReply: false,
            ticket: _sortTicketReplies(rolledBackTicket),
            errorMessage: failure.message,
            actionMessage: null,
          ),
        );
      },
      (reply) {
        final currentTicket = state.ticket ?? optimisticTicket;
        final syncedReplies =
            (currentTicket.replies ?? const <TicketReplyEntity>[])
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
            errorMessage: null,
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
        errorMessage: null,
        actionMessage: null,
      ),
    );

    final result = await _closeTicketUseCase(
      CloseTicketParams(ticketId: ticket.id),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isClosingTicket: false,
          errorMessage: failure.message,
          actionMessage: null,
        ),
      ),
      (updatedTicket) => emit(
        state.copyWith(
          isClosingTicket: false,
          ticket: _sortTicketReplies(updatedTicket),
          actionMessage: 'Ticket marked as closed',
          errorMessage: null,
        ),
      ),
    );
  }

  void clearMessages() {
    emit(state.copyWith(errorMessage: null, actionMessage: null));
  }

  _TicketSnapshot _copyTicket(
    TicketEntity source, {
    List<TicketReplyEntity>? replies,
    String? updatedAt,
  }) {
    return _TicketSnapshot(
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

  TicketEntity _sortTicketReplies(TicketEntity ticket) {
    return _copyTicket(
      ticket,
      replies: _sortReplies(ticket.replies ?? const <TicketReplyEntity>[]),
    );
  }

  List<TicketReplyEntity> _sortReplies(List<TicketReplyEntity> replies) {
    final sorted = List<TicketReplyEntity>.from(replies);
    sorted.sort(
      (a, b) => _parseDate(a.createdAt).compareTo(_parseDate(b.createdAt)),
    );
    return sorted;
  }

  DateTime _parseDate(String value) {
    return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  TicketReplyUserEntity _currentUserFromReplies(
    List<TicketReplyEntity>? replies,
  ) {
    if (replies == null) {
      return const _TicketReplyUserSnapshot(
        id: 0,
        name: 'You',
        role: 'customer',
      );
    }

    for (final reply in replies.reversed) {
      if (!reply.isStaffReply && reply.user != null) {
        return reply.user!;
      }
    }

    return const _TicketReplyUserSnapshot(id: 0, name: 'You', role: 'customer');
  }
}

class _TicketSnapshot extends TicketEntity {
  @override
  final int id;
  @override
  final String ticketNumber;
  @override
  final int userId;
  @override
  final int? orderId;
  @override
  final String subject;
  @override
  final String description;
  @override
  final String category;
  @override
  final String priority;
  @override
  final TicketStatus status;
  @override
  final String? assignedTo;
  @override
  final String? firstResponseAt;
  @override
  final String? resolvedAt;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final List<TicketReplyEntity>? replies;

  const _TicketSnapshot({
    required this.id,
    required this.ticketNumber,
    required this.userId,
    required this.orderId,
    required this.subject,
    required this.description,
    required this.category,
    required this.priority,
    required this.status,
    required this.assignedTo,
    required this.firstResponseAt,
    required this.resolvedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.replies,
  });
}

class _TicketReplySnapshot extends TicketReplyEntity {
  @override
  final int id;
  @override
  final int ticketId;
  @override
  final int userId;
  @override
  final String message;
  @override
  final bool isStaffReply;
  @override
  final String? attachments;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final TicketReplyUserEntity? user;

  const _TicketReplySnapshot({
    required this.id,
    required this.ticketId,
    required this.userId,
    required this.message,
    required this.isStaffReply,
    required this.attachments,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });
}

class _TicketReplyUserSnapshot extends TicketReplyUserEntity {
  @override
  final int id;
  @override
  final String name;
  @override
  final String role;

  const _TicketReplyUserSnapshot({
    required this.id,
    required this.name,
    required this.role,
  });
}
