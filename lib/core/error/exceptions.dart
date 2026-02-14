/// Base exception for all server-related errors
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (statusCode: $statusCode)';
}

/// Exception for when there is no internet connection
class NoInternetException implements Exception {
  final String message;

  const NoInternetException({this.message = 'No internet connection'});

  @override
  String toString() => 'NoInternetException: $message';
}

/// Exception for cache operations
class CacheException implements Exception {
  final String message;

  const CacheException({this.message = 'Cache error occurred'});

  @override
  String toString() => 'CacheException: $message';
}

/// Exception for unauthorized access (401)
class UnauthorizedException implements Exception {
  final String message;

  const UnauthorizedException({this.message = 'Unauthorized access'});

  @override
  String toString() => 'UnauthorizedException: $message';
}
