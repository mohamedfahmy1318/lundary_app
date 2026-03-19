import 'package:json_annotation/json_annotation.dart';

part 'ticket_model.g.dart';

enum TicketStatus {
  @JsonValue('open') open,
  @JsonValue('in_progress') inProgress,
  @JsonValue('resolved') resolved,
  @JsonValue('closed') closed,
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
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => _$TicketModelFromJson(json);
  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
