import 'package:laundry/features/profile/domain/entities/ticket_reply_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_status.dart';

abstract class TicketEntity {
  const TicketEntity();

  int get id;
  String get ticketNumber;
  int get userId;
  int? get orderId;
  String get subject;
  String get description;
  String get category;
  String get priority;
  TicketStatus get status;
  String? get assignedTo;
  String? get firstResponseAt;
  String? get resolvedAt;
  String get createdAt;
  String get updatedAt;
  List<TicketReplyEntity>? get replies;

  bool get isClosed => status == TicketStatus.closed;

  bool get isOpen {
    return status == TicketStatus.open ||
        status == TicketStatus.inProgress ||
        status == TicketStatus.waitingCustomer;
  }
}
