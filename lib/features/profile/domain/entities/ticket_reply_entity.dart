import 'package:laundry/features/profile/domain/entities/ticket_reply_user_entity.dart';

abstract class TicketReplyEntity {
  const TicketReplyEntity();

  int get id;
  int get ticketId;
  int get userId;
  String get message;
  bool get isStaffReply;
  String? get attachments;
  String get createdAt;
  String get updatedAt;
  TicketReplyUserEntity? get user;
}
