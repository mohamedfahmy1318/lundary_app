// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
  id: (json['id'] as num).toInt(),
  ticketNumber: json['ticket_number'] as String,
  userId: (json['user_id'] as num).toInt(),
  orderId: (json['order_id'] as num?)?.toInt(),
  subject: json['subject'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  priority: json['priority'] as String,
  status: $enumDecode(_$TicketStatusEnumMap, json['status']),
  assignedTo: json['assigned_to'] as String?,
  firstResponseAt: json['first_response_at'] as String?,
  resolvedAt: json['resolved_at'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  replies:
      (json['replies'] as List<dynamic>?)
          ?.map((e) => TicketReplyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticket_number': instance.ticketNumber,
      'user_id': instance.userId,
      'order_id': instance.orderId,
      'subject': instance.subject,
      'description': instance.description,
      'category': instance.category,
      'priority': instance.priority,
      'status': _$TicketStatusEnumMap[instance.status]!,
      'assigned_to': instance.assignedTo,
      'first_response_at': instance.firstResponseAt,
      'resolved_at': instance.resolvedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'replies': instance.replies,
    };

const _$TicketStatusEnumMap = {
  TicketStatus.open: 'open',
  TicketStatus.inProgress: 'in_progress',
  TicketStatus.resolved: 'resolved',
  TicketStatus.closed: 'closed',
};

TicketReplyModel _$TicketReplyModelFromJson(Map<String, dynamic> json) =>
    TicketReplyModel(
      id: (json['id'] as num).toInt(),
      ticketId: (json['ticket_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      message: json['message'] as String,
      isStaffReply: json['is_staff_reply'] as bool,
      attachments: json['attachments'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      user:
          json['user'] == null
              ? null
              : ReplyUserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TicketReplyModelToJson(TicketReplyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ticket_id': instance.ticketId,
      'user_id': instance.userId,
      'message': instance.message,
      'is_staff_reply': instance.isStaffReply,
      'attachments': instance.attachments,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'user': instance.user,
    };

ReplyUserModel _$ReplyUserModelFromJson(Map<String, dynamic> json) =>
    ReplyUserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$ReplyUserModelToJson(ReplyUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
    };
