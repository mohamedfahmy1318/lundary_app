import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _userBoxName = 'user_box';
  static const String _cacheBoxName = 'cache_box';
  static const String _settingsBoxName = 'settings_box';

  /// Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters here
    // Hive.registerAdapter(YourModelAdapter());

    // Open boxes
    await Hive.openBox(_userBoxName);
    await Hive.openBox(_cacheBoxName);
    await Hive.openBox(_settingsBoxName);
  }

  // User Box
  static Box get userBox => Hive.box(_userBoxName);

  // Cache Box
  static Box get cacheBox => Hive.box(_cacheBoxName);

  // Settings Box
  static Box get settingsBox => Hive.box(_settingsBoxName);

  /// Save data to a specific box
  static Future<void> saveData<T>({
    required String boxName,
    required String key,
    required T value,
  }) async {
    final box = Hive.box(boxName);
    await box.put(key, value);
  }

  /// Get data from a specific box
  static T? getData<T>({required String boxName, required String key}) {
    final box = Hive.box(boxName);
    return box.get(key) as T?;
  }

  /// Delete data from a specific box
  static Future<void> deleteData({
    required String boxName,
    required String key,
  }) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  /// Clear a specific box
  static Future<int> clearBox(String boxName) async {
    final box = Hive.box(boxName);
    return box.clear();
  }

  /// Clear all boxes
  static Future<void> clearAll() async {
    await userBox.clear();
    await cacheBox.clear();
    await settingsBox.clear();
  }

  /// Close all boxes
  static Future<void> closeAll() async {
    await Hive.close();
  }
}
