import 'package:dio/dio.dart';
import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/services/local_storage_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  late final Dio _dio;
  final LocalStorageService _localStorageService;

  ApiClient({required LocalStorageService localStorageService})
    : _localStorageService = localStorageService {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(
          milliseconds: ApiConstants.connectTimeout,
        ),
        receiveTimeout: const Duration(
          milliseconds: ApiConstants.receiveTimeout,
        ),
        sendTimeout: const Duration(milliseconds: ApiConstants.sendTimeout),
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
        },
      ),
    );

    _dio.interceptors.addAll([
      _AuthInterceptor(localStorageService: _localStorageService),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);
  }

  // GET
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // POST
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // PUT
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // DELETE
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // PATCH
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  /// Handles DioException and converts them to app-specific exceptions
  Exception _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerException(message: 'Connection timeout');
      case DioExceptionType.connectionError:
        return const NoInternetException();
      case DioExceptionType.badResponse:
        return _handleBadResponse(e.response);
      default:
        return ServerException(message: e.message ?? 'Unknown error');
    }
  }

  Exception _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;
    final message = data is Map
        ? data['message'] ?? 'Server error'
        : 'Server error';

    switch (statusCode) {
      case 401:
        return UnauthorizedException(message: message);
      case 403:
        return ServerException(message: 'Forbidden: $message', statusCode: 403);
      case 404:
        return ServerException(message: 'Not found: $message', statusCode: 404);
      case 422:
        return ServerException(message: message, statusCode: 422);
      case 500:
        return ServerException(
          message: 'Internal server error',
          statusCode: 500,
        );
      default:
        return ServerException(message: message, statusCode: statusCode);
    }
  }
}

/// Interceptor to attach auth token to requests
class _AuthInterceptor extends Interceptor {
  final LocalStorageService _localStorageService;

  _AuthInterceptor({required LocalStorageService localStorageService})
    : _localStorageService = localStorageService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _localStorageService.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorization] =
          '${ApiConstants.bearer} $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Handle token refresh or logout here
      _localStorageService.clearToken();
    }
    handler.next(err);
  }
}
