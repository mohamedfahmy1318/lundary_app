import 'package:laundry/core/services/push_notification_service.dart';

@Deprecated('Use PushNotificationService instead.')
class NotificationService {
  static Future<void> initialize() => PushNotificationService.initialize();

  static Future<String> getToken() => PushNotificationService.getToken();

  static String get currentToken => PushNotificationService.currentToken;
}
