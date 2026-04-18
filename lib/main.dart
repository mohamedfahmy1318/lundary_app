import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laundry/app.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/core/services/hive_service.dart';
import 'package:laundry/core/utils/app_helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Catch Flutter framework errors
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // TODO: Send to crash reporting service (e.g., Firebase Crashlytics)
  };

  // Catch errors outside the Flutter framework (e.g., in async code)
  PlatformDispatcher.instance.onError = (error, stack) {
    // TODO: Send to crash reporting service
    debugPrint('Uncaught error: $error\n$stack');
    return true;
  };

  await AppHelpers.setPortraitOnly();
  await HiveService.init();
  await setupDependencies();
  await Firebase.initializeApp();
  //await PushNotificationService.initialize();

  runApp(const MyApp());
}
