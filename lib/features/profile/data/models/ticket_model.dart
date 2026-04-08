import 'package:json_annotation/json_annotation.dart';

part 'ticket_model.g.dart';

enum TicketStatus {
  @JsonValue('open')
  open,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('resolved')
  resolved,
  @JsonValue('closed')
  closed,
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TicketModel {
  final int id;
  final String ticketNumber;
  final int userId;
  final int? orderId;
  final String subject;
  final String description;
  final String category;
  final String priority;
  final TicketStatus status;
  final String? assignedTo;
  final String? firstResponseAt;
  final String? resolvedAt;
  final String createdAt;
  final String updatedAt;
  final List<TicketReplyModel>? replies;

  TicketModel({
    required this.id,
    required this.ticketNumber,
    required this.userId,
    this.orderId,
    required this.subject,
    required this.description,
    required this.category,
    required this.priority,
    required this.status,
    this.assignedTo,
    this.firstResponseAt,
    this.resolvedAt,
    required this.createdAt,
    required this.updatedAt,
    this.replies,
  });

  bool get isClosed => status == TicketStatus.closed;
  bool get isOpen =>
      status == TicketStatus.open || status == TicketStatus.inProgress;

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);
  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TicketReplyModel {
  final int id;
  final int ticketId;
  final int userId;
  final String message;
  final bool isStaffReply;
  final String? attachments;
  final String createdAt;
  final String updatedAt;
  final ReplyUserModel? user;

  TicketReplyModel({
    required this.id,
    required this.ticketId,
    required this.userId,
    required this.message,
    required this.isStaffReply,
    this.attachments,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory TicketReplyModel.fromJson(Map<String, dynamic> json) =>
      _$TicketReplyModelFromJson(json);
  Map<String, dynamic> toJson() => _$TicketReplyModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReplyUserModel {
  final int id;
  final String name;
  final String role;

  ReplyUserModel({required this.id, required this.name, required this.role});

  factory ReplyUserModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyUserModelToJson(this);
}
