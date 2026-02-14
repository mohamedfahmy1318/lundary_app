import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

/// Wrapper for standard API responses.
///
/// IMPORTANT: Change the field names to match YOUR backend response shape.
/// Open any endpoint from your API and check the JSON keys, then update below.
///
/// Common shapes:
///   Laravel:  { "status": true, "message": "...", "data": { ... } }  ← current
///   Other:    { "success": true, "result": { ... }, "error": null }
///   Other:    { "code": 200, "msg": "OK", "body": { ... } }
///
/// If your backend uses different keys (e.g. "result" instead of "data"),
/// just use @JsonKey(name: 'result') on the field.
///
/// Usage:
///   final response = `BaseResponse<UserModel>`.fromJson(
///     json,
///     (data) => UserModel.fromJson(data as `Map<String, dynamic>`),
///   );
///   final user = response.data!;
@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  // ── Change these to match your backend ──
  final bool? status; // or: @JsonKey(name: 'success') final bool? status;
  final String? message; // or: @JsonKey(name: 'msg') final String? message;
  final T? data; // or: @JsonKey(name: 'result') final T? data;

  const BaseResponse({this.status, this.message, this.data});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}

/// For paginated API responses:
/// { "status": true, "data": [...], "current_page": 1, "last_page": 5 }
@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  final List<T>? data;
  @JsonKey(name: 'current_page')
  final int? currentPage;
  @JsonKey(name: 'last_page')
  final int? lastPage;
  @JsonKey(name: 'per_page')
  final int? perPage;
  final int? total;

  const PaginatedResponse({
    this.data,
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  bool get hasMorePages => (currentPage ?? 0) < (lastPage ?? 0);

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginatedResponseFromJson(json, fromJsonT);
}
