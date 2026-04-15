import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/profile/domain/entities/ticket_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_lookup_option_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_reply_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_reply_user_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_status.dart';

part 'ticket_model.freezed.dart';
part 'ticket_model.g.dart';

class TicketStatusJsonConverter
    implements JsonConverter<TicketStatus, Object?> {
  const TicketStatusJsonConverter();

  @override
  TicketStatus fromJson(Object? json) => _ticketStatusFromJson(json);

  @override
  Object? toJson(TicketStatus object) => object.apiValue;
}

TicketStatus _ticketStatusFromJson(Object? value) {
  final normalized = value
      ?.toString()
      .trim()
      .toLowerCase()
      .replaceAll('-', '_')
      .replaceAll(' ', '_');

  switch (normalized) {
    case 'in_progress':
      return TicketStatus.inProgress;
    case 'waiting_customer':
      return TicketStatus.waitingCustomer;
    case 'resolved':
      return TicketStatus.resolved;
    case 'closed':
      return TicketStatus.closed;
    case 'open':
    default:
      return TicketStatus.open;
  }
}

int _parseInt(Object? value, {int fallback = 0}) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  return int.tryParse(value?.toString() ?? '') ?? fallback;
}

String _parseString(Object? value, {String fallback = ''}) {
  final parsed = value?.toString();
  if (parsed == null || parsed.trim().isEmpty || parsed == 'null') {
    return fallback;
  }
  return parsed;
}

String? _parseNullableString(Object? value) {
  final parsed = value?.toString();
  if (parsed == null || parsed.trim().isEmpty || parsed == 'null') {
    return null;
  }
  return parsed;
}

bool _parseBool(Object? value, {bool fallback = false}) {
  if (value is bool) {
    return value;
  }
  final normalized = value?.toString().trim().toLowerCase();
  if (normalized == '1' || normalized == 'true' || normalized == 'yes') {
    return true;
  }
  if (normalized == '0' || normalized == 'false' || normalized == 'no') {
    return false;
  }
  return fallback;
}

@freezed
abstract class TicketLookupOptionModel extends TicketLookupOptionEntity
    with _$TicketLookupOptionModel {
  const TicketLookupOptionModel._();

  const factory TicketLookupOptionModel({
    required String value,
    required String label,
  }) = _TicketLookupOptionModel;

  factory TicketLookupOptionModel.fromJson(Map<String, dynamic> json) =>
      _$TicketLookupOptionModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return <String, dynamic>{
      ...json,
      'value': _parseString(json['value']),
      'label': _parseString(json['label']),
    };
  }
}

@freezed
abstract class TicketReplyUserModel extends TicketReplyUserEntity
    with _$TicketReplyUserModel {
  const TicketReplyUserModel._();

  const factory TicketReplyUserModel({
    required int id,
    required String name,
    required String role,
  }) = _TicketReplyUserModel;

  factory TicketReplyUserModel.fromJson(Map<String, dynamic> json) =>
      _$TicketReplyUserModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    return <String, dynamic>{
      ...json,
      'id': _parseInt(json['id']),
      'name': _parseString(json['name']),
      'role': _parseString(json['role']),
    };
  }
}

@freezed
abstract class TicketReplyModel extends TicketReplyEntity
    with _$TicketReplyModel {
  const TicketReplyModel._();

  const factory TicketReplyModel({
    required int id,
    @JsonKey(name: 'ticket_id') required int ticketId,
    @JsonKey(name: 'user_id') required int userId,
    required String message,
    @JsonKey(name: 'is_staff_reply') required bool isStaffReply,
    String? attachments,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    TicketReplyUserModel? user,
  }) = _TicketReplyModel;

  factory TicketReplyModel.fromJson(Map<String, dynamic> json) =>
      _$TicketReplyModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final userJson = json['user'];

    return <String, dynamic>{
      ...json,
      'id': _parseInt(json['id']),
      'ticket_id': _parseInt(json['ticket_id'] ?? json['ticketId']),
      'user_id': _parseInt(json['user_id'] ?? json['userId']),
      'message': _parseString(json['message']),
      'is_staff_reply': _parseBool(
        json['is_staff_reply'] ?? json['isStaffReply'],
      ),
      'attachments': _parseNullableString(json['attachments']),
      'created_at': _parseString(json['created_at'] ?? json['createdAt']),
      'updated_at': _parseString(json['updated_at'] ?? json['updatedAt']),
      'user':
          userJson is Map
              ? TicketReplyUserModel._normalizeJson(
                Map<String, dynamic>.from(userJson),
              )
              : null,
    };
  }
}

@freezed
abstract class TicketModel extends TicketEntity with _$TicketModel {
  const TicketModel._();

  const factory TicketModel({
    required int id,
    @JsonKey(name: 'ticket_number') required String ticketNumber,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'order_id') int? orderId,
    required String subject,
    required String description,
    required String category,
    required String priority,
    @TicketStatusJsonConverter() required TicketStatus status,
    @JsonKey(name: 'assigned_to') String? assignedTo,
    @JsonKey(name: 'first_response_at') String? firstResponseAt,
    @JsonKey(name: 'resolved_at') String? resolvedAt,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    List<TicketReplyModel>? replies,
  }) = _TicketModel;

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(_normalizeJson(json));

  static Map<String, dynamic> _normalizeJson(Map<String, dynamic> json) {
    final rawReplies = json['replies'];
    final normalizedReplies =
        rawReplies is List
            ? rawReplies.whereType<Map>().map((reply) {
              return TicketReplyModel._normalizeJson(
                Map<String, dynamic>.from(reply),
              );
            }).toList()
            : null;

    return <String, dynamic>{
      ...json,
      'id': _parseInt(json['id']),
      'ticket_number': _parseString(
        json['ticket_number'] ?? json['ticketNumber'],
      ),
      'user_id': _parseInt(json['user_id'] ?? json['userId']),
      'order_id': json['order_id'] ?? json['orderId'],
      'subject': _parseString(json['subject']),
      'description': _parseString(json['description']),
      'category': _parseString(json['category']),
      'priority': _parseString(json['priority']),
      'status': json['status'],
      'assigned_to': _parseNullableString(
        json['assigned_to'] ?? json['assignedTo'],
      ),
      'first_response_at': _parseNullableString(
        json['first_response_at'] ?? json['firstResponseAt'],
      ),
      'resolved_at': _parseNullableString(
        json['resolved_at'] ?? json['resolvedAt'],
      ),
      'created_at': _parseString(json['created_at'] ?? json['createdAt']),
      'updated_at': _parseString(json['updated_at'] ?? json['updatedAt']),
      'replies': normalizedReplies,
    };
  }
}
