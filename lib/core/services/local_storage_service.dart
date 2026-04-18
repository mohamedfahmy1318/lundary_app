import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences _prefs;
  late final ValueNotifier<bool> authStateNotifier;

  LocalStorageService({required SharedPreferences prefs}) : _prefs = prefs {
    authStateNotifier = ValueNotifier<bool>(
      _prefs.getBool(_isLoggedInKey) ?? false,
    );
  }

  // Keys
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _languageKey = 'language';
  static const String _themeKey = 'theme_mode';
  static const String _isFirstTimeKey = 'is_first_time';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _currentLocationKey = 'current_location';
  static const String _savedLocationsKey = 'saved_locations';

  // Token
  Future<bool> saveToken(String token) => _prefs.setString(_tokenKey, token);
  String? getToken() => _prefs.getString(_tokenKey);
  Future<bool> clearToken() => _prefs.remove(_tokenKey);

  // Refresh Token
  Future<bool> saveRefreshToken(String token) =>
      _prefs.setString(_refreshTokenKey, token);
  String? getRefreshToken() => _prefs.getString(_refreshTokenKey);

  // User ID
  Future<bool> saveUserId(String id) => _prefs.setString(_userIdKey, id);
  String? getUserId() => _prefs.getString(_userIdKey);

  // Language
  Future<bool> saveLanguage(String lang) =>
      _prefs.setString(_languageKey, lang);
  String getLanguage() => _prefs.getString(_languageKey) ?? 'en';

  // Theme
  Future<bool> saveThemeMode(String mode) => _prefs.setString(_themeKey, mode);
  String getThemeMode() => _prefs.getString(_themeKey) ?? 'light';

  // First Time
  Future<bool> setFirstTime(bool value) =>
      _prefs.setBool(_isFirstTimeKey, value);
  bool isFirstTime() => _prefs.getBool(_isFirstTimeKey) ?? true;

  // Logged In
  Future<bool> setLoggedIn(bool value) async {
    final result = await _prefs.setBool(_isLoggedInKey, value);
    authStateNotifier.value = value;
    return result;
  }

  bool isLoggedIn() => authStateNotifier.value;

  // Current Location
  Future<bool> saveCurrentLocation(String location) =>
      _prefs.setString(_currentLocationKey, location);
  String? getCurrentLocation() => _prefs.getString(_currentLocationKey);

  // Saved Locations
  Future<bool> saveSavedLocations(List<String> locations) =>
      _prefs.setStringList(_savedLocationsKey, locations);
  List<String> getSavedLocations() =>
      _prefs.getStringList(_savedLocationsKey) ?? const <String>[];

  // Clear all data (for logout)
  Future<bool> clearAll() async {
    final result = await _prefs.clear();
    authStateNotifier.value = false;
    return result;
  }
}
