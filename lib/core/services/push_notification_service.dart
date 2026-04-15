import 'dart:convert';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:laundry/core/routing/app_router.dart';
import 'package:laundry/core/routing/routing_names.dart';
import 'package:laundry/features/orders/data/models/order_model.dart';
import 'package:laundry/features/orders/domain/entities/order_status.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationService.showBackgroundNotification(message);
  debugPrint(
    'FCM background message: ${message.messageId}, data: ${message.data}',
  );
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse response) {
  debugPrint('Notification background tap payload: ${response.payload}');
}

class PushNotificationService {
  PushNotificationService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _highImportanceChannel =
      AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description:
            'Used for important notifications while app is foreground.',
        importance: Importance.max,
      );

  static final Set<String> _handledMessageIds = <String>{};

  static String _fcmToken = '';
  static bool _isInitialized = false;
  static bool _localNotificationsReady = false;

  static String get currentToken => _fcmToken;

  static Future<String> getToken() async {
    if (_fcmToken.isNotEmpty) {
      return _fcmToken;
    }

    _fcmToken = await _messaging.getToken() ?? '';
    return _fcmToken;
  }

  static Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _ensureLocalNotificationsInitialized();
    await _requestPermissions();
    await _configureForegroundPresentation();
    await _configureTokenTracking();

    _listenForegroundMessages();
    _listenNotificationTaps();

    final launchDetails =
        await _localNotificationsPlugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      _handleLocalNotificationTap(launchDetails?.notificationResponse?.payload);
    }

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleRemoteMessageTap(initialMessage);
    }

    _isInitialized = true;
  }

  static Future<void> _ensureLocalNotificationsInitialized() async {
    if (_localNotificationsReady) {
      return;
    }

    const androidInitialization = AndroidInitializationSettings(
      '@drawable/ic_launcher_foreground',
    );
    const iosInitialization = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: androidInitialization,
      iOS: iosInitialization,
    );

    await _localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        _handleLocalNotificationTap(response.payload);
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    final androidImplementation =
        _localNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    await androidImplementation?.createNotificationChannel(
      _highImportanceChannel,
    );

    _localNotificationsReady = true;
  }

  static Future<void> _requestPermissions() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    debugPrint('FCM permission status: ${settings.authorizationStatus}');

    final androidImplementation =
        _localNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    await androidImplementation?.requestNotificationsPermission();

    final iosImplementation =
        _localNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();
    await iosImplementation?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> _configureForegroundPresentation() async {
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Future<void> _configureTokenTracking() async {
    _fcmToken = await _messaging.getToken() ?? '';
    debugPrint('FCM token: $_fcmToken');

    _messaging.onTokenRefresh.listen((token) {
      _fcmToken = token;
      debugPrint('FCM token refreshed: $token');
    });
  }

  static void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((message) async {
      await _showLocalNotificationFromMessage(message);
    });
  }

  static void _listenNotificationTaps() {
    FirebaseMessaging.onMessageOpenedApp.listen(_handleRemoteMessageTap);
  }

  static Future<void> showBackgroundNotification(RemoteMessage message) async {
    if (message.notification != null) {
      return;
    }

    await _ensureLocalNotificationsInitialized();
    await _showLocalNotificationFromMessage(message);
  }

  static Future<void> _showLocalNotificationFromMessage(
    RemoteMessage message,
  ) async {
    final title =
        message.notification?.title ??
        message.data['title']?.toString() ??
        'Laundry';
    final body =
        message.notification?.body ??
        message.data['body']?.toString() ??
        'You have a new update.';

    final notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        _highImportanceChannel.id,
        _highImportanceChannel.name,
        channelDescription: _highImportanceChannel.description,
        importance: Importance.max,
        priority: Priority.high,
        icon: 'ic_launcher_foreground',
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _localNotificationsPlugin.show(
      message.messageId?.hashCode ??
          DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  static void _handleLocalNotificationTap(String? payload) {
    if (payload == null || payload.isEmpty) {
      return;
    }

    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map) {
        _routeFromNotificationData(Map<String, dynamic>.from(decoded));
      }
    } catch (e) {
      debugPrint('Unable to parse local notification payload: $e');
    }
  }

  static void _handleRemoteMessageTap(RemoteMessage message) {
    if (!_shouldHandleMessage(message)) {
      return;
    }

    _routeWhenReady(message.data);
  }

  static bool _shouldHandleMessage(RemoteMessage message) {
    final messageId = message.messageId;
    if (messageId == null || messageId.isEmpty) {
      return true;
    }

    if (_handledMessageIds.contains(messageId)) {
      return false;
    }

    _handledMessageIds.add(messageId);
    return true;
  }

  static void _routeWhenReady(Map<String, dynamic> data) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _routeFromNotificationData(data);
    });
  }

  static void _routeFromNotificationData(Map<String, dynamic> data) {
    final orderId = _parseInt(data['order_id'] ?? data['orderId']);

    if (orderId != null) {
      final order = _buildOrderFromNotificationData(orderId, data);
      AppRouter.router.push(RoutingNames.orderDetails, extra: order);
      return;
    }

    AppRouter.router.go(RoutingNames.main);
  }

  static OrderModel _buildOrderFromNotificationData(
    int orderId,
    Map<String, dynamic> data,
  ) {
    return OrderModel(
      id: orderId,
      orderNumber: (data['order_number'] ?? orderId).toString(),
      userId: _parseInt(data['user_id']) ?? 0,
      status: _parseOrderStatus(data['status']?.toString()),
      pickupDate: data['pickup_date']?.toString(),
      pickupTimeSlot: data['pickup_time_slot']?.toString(),
      pickupAddress: data['pickup_address']?.toString(),
      deliveryDate: data['delivery_date']?.toString(),
      deliveryTimeSlot: data['delivery_time_slot']?.toString(),
      deliveryAddress: data['delivery_address']?.toString(),
      subtotal: (data['subtotal'] ?? '0').toString(),
      deliveryFee: (data['delivery_fee'] ?? '0').toString(),
      discountAmount: (data['discount_amount'] ?? '0').toString(),
      totalAmount: (data['total_amount'] ?? data['total'] ?? '0').toString(),
      paymentMethod: data['payment_method']?.toString(),
      paymentStatus: data['payment_status']?.toString(),
      notes: data['notes']?.toString(),
      promoCode: data['promo_code']?.toString(),
      isExpress: _parseBool(data['is_express']),
      cancelledAt: data['cancelled_at']?.toString(),
      cancellationReason: data['cancellation_reason']?.toString(),
      createdAt: data['created_at']?.toString(),
      updatedAt: data['updated_at']?.toString(),
      items: null,
    );
  }

  static int? _parseInt(Object? value) {
    if (value == null) {
      return null;
    }
    if (value is int) {
      return value;
    }
    return int.tryParse(value.toString());
  }

  static bool _parseBool(Object? value) {
    if (value is bool) {
      return value;
    }
    final normalized = value?.toString().toLowerCase();
    return normalized == '1' || normalized == 'true' || normalized == 'yes';
  }

  static OrderStatus _parseOrderStatus(String? value) {
    final normalized = value
        ?.toLowerCase()
        .replaceAll('-', '_')
        .replaceAll(' ', '_');

    switch (normalized) {
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'picking_up':
        return OrderStatus.pickingUp;
      case 'picked_up':
        return OrderStatus.pickedUp;
      case 'processing':
        return OrderStatus.processing;
      case 'ready':
        return OrderStatus.ready;
      case 'out_for_delivery':
        return OrderStatus.outForDelivery;
      case 'delivered':
        return OrderStatus.delivered;
      case 'completed':
        return OrderStatus.completed;
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'pending':
      default:
        return OrderStatus.pending;
    }
  }
}
