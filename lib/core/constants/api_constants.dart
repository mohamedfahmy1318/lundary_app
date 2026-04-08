abstract class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://laundry.findosystem.com/api/v1';

  // Timeout durations (in milliseconds)
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;
  static const int sendTimeout = 30000;

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verify = '/auth/verify';
  static const String resend = '/auth/resend';
  static const String logout = '/auth/logout';

  // Home
  static const String categories = '/categories';
  static const String services = '/services';
  static const String products = '/products';
  static const String banners = '/settings/banners';

  // Orders
  static const String orders = '/orders';

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
  static String ticketDetails(int ticketId) => '$tickets/$ticketId';
  static String ticketReply(int ticketId) => '${ticketDetails(ticketId)}/reply';
  static String closeTicket(int ticketId) => '${ticketDetails(ticketId)}/close';
  static const String subscriptionPlans = '/subscription-plans';
  static const String mySubscriptions = '/subscriptions/my';
  static const String onboarding = '/settings/onboarding';
  static const String updateProfile = '/auth/profile';

  // Headers
  static const String contentType = 'application/json';
  static const String accept = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
}
