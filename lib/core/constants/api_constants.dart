abstract class ApiConstants {
  // Base URL - change this to your API base URL
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // Timeout durations (in milliseconds)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // Products API
  static const String productsBaseUrl = 'https://api.escuelajs.co/api/v1';
  static const String products = '/products';

  // Endpoints
  static const String posts = '/posts';
  static const String users = '/users';
  static const String comments = '/comments';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verify = '/auth/verify';
  static const String resend = '/auth/resend';

  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
}
