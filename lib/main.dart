import 'package:flutter/material.dart';

import 'package:laundry/app.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/core/services/hive_service.dart';
import 'package:laundry/core/utils/app_helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set portrait orientation only
  await AppHelpers.setPortraitOnly();

  // Initialize Hive
  await HiveService.init();

  // Setup dependency injection
  await setupDependencies();

  // Initialize Firebase (uncomment when needed)
  // await Firebase.initializeApp();

  runApp(const MyApp());
}
