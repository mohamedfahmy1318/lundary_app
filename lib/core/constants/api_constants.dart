abstract class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://laundry.findosystem.com/api/v1';

  // Timeout durations (in milliseconds)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // Auth
  static const String registerRequest = '/auth/register-request';
  static const String registerVerify = '/auth/register-verify';
  static const String loginRequest = '/auth/login-request';
  static const String loginVerify = '/auth/login-verify';
  static const String socialAuth = '/auth/social';
  static const String resendOtp = '/auth/resend-otp';
  static const String logout = '/auth/logout';

  // Home
  static const String categories = '/categories';
  static const String services = '/services';
  static const String topServices = '/services/top';
  static const String products = '/products';
  static const String banners = '/settings/banners';

  // Orders
  static const String orders = '/orders';
  static String paymentInitiate(int orderId) => '/payment/initiate/$orderId';
  static String paymentStatus(int orderId) => '/payment/status/$orderId';

  // Basket
  static const String basket = '/basket';

  // Settings
  static const String timeslots = '/settings/timeslots';

  // Wallet
  static const String wallet = '/wallet';
  static const String walletTopUp = '/wallet/top-up';
  static const String walletCards = '/wallet/cards';
  static const String walletFamily = '/wallet/family';
  static const String walletTransactions = '/wallet/transactions';

  // Profile
  static const String profile = '/auth/profile';
  static const String changePassword = '/auth/change-password';
  static const String tickets = '/support/tickets';
  static const String supportCategories = '/support/categories';
  static const String supportPriorities = '/support/priorities';
  static const String supportStatuses = '/support/statuses';
  static String ticketDetails(int ticketId) => '$tickets/$ticketId';
  static String ticketReply(int ticketId) => '${ticketDetails(ticketId)}/reply';
  static String closeTicket(int ticketId) => '${ticketDetails(ticketId)}/close';
  static const String subscriptionPlans = '/subscription-plans';
  static const String mySubscriptions = '/subscriptions/my';
  static const String subscribeToPlan = '/subscriptions/subscribe';
  static const String onboarding = '/settings/onboarding';
  static const String updateProfile = '/auth/profile';

  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
}
