import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

/// Generic wrapper for API results using Freezed
/// Usage:
///   `ApiResult<List<Post>> result = await repo.getPosts();`
///   result.when(
///     success: (data) => ...,
///     failure: (error) => ...,
///   );
@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = Success<T>;
  const factory ApiResult.failure(String error) = Failure<T>;
}
