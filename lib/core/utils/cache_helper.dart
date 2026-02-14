import 'dart:convert';

import 'package:laundry/core/services/hive_service.dart';

/// A utility class for managing cached data with TTL (Time-To-Live) support.
///
/// Uses Hive under the hood, storing data as JSON strings with timestamps.
///
/// Usage:
///   // Cache data
///   await CacheHelper.cacheData(key: 'products', data: jsonList);
///
///   // Retrieve cached data
///   final data = CacheHelper.getCachedData<`List<dynamic>`>(key: 'products');
///
///   // Check validity
///   if (CacheHelper.isCacheValid('products')) { ... }
class CacheHelper {
  static const Duration defaultCacheDuration = Duration(minutes: 30);
  static const String _boxName = 'cache_box';

  /// Cache any JSON-encodable data with a timestamp and TTL.
  static Future<void> cacheData({
    required String key,
    required dynamic data,
    Duration? duration,
  }) async {
    final cacheEntry = {
      'data': data,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'duration': (duration ?? defaultCacheDuration).inMilliseconds,
    };
    await HiveService.saveData(
      boxName: _boxName,
      key: key,
      value: jsonEncode(cacheEntry),
    );
  }

  /// Retrieve cached data. Returns null if expired or not found.
  ///
  /// Use [fromJson] to convert the raw cached data into your model.
  static T? getCachedData<T>({
    required String key,
    T Function(dynamic json)? fromJson,
  }) {
    final raw = HiveService.getData<String>(boxName: _boxName, key: key);
    if (raw == null) return null;

    try {
      final cacheEntry = jsonDecode(raw) as Map<String, dynamic>;
      final timestamp = cacheEntry['timestamp'] as int;
      final duration = cacheEntry['duration'] as int;

      // Check if cache has expired
      if (DateTime.now().millisecondsSinceEpoch - timestamp > duration) {
        // Expired → remove it
        HiveService.deleteData(boxName: _boxName, key: key);
        return null;
      }

      final data = cacheEntry['data'];
      if (fromJson != null) return fromJson(data);
      return data as T;
    } catch (_) {
      // If decoding fails, remove corrupted entry
      HiveService.deleteData(boxName: _boxName, key: key);
      return null;
    }
  }

  /// Check if a cache entry exists and is still valid (not expired).
  static bool isCacheValid(String key) {
    final raw = HiveService.getData<String>(boxName: _boxName, key: key);
    if (raw == null) return false;

    try {
      final cacheEntry = jsonDecode(raw) as Map<String, dynamic>;
      final timestamp = cacheEntry['timestamp'] as int;
      final duration = cacheEntry['duration'] as int;
      return DateTime.now().millisecondsSinceEpoch - timestamp <= duration;
    } catch (_) {
      return false;
    }
  }

  /// Invalidate (delete) a specific cache entry.
  static Future<void> invalidateCache(String key) async {
    await HiveService.deleteData(boxName: _boxName, key: key);
  }

  /// Clear all cached data.
  static Future<void> clearAllCache() async {
    await HiveService.clearBox(_boxName);
  }
}
