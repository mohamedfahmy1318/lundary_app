import 'package:laundry/core/services/local_storage_service.dart';
import 'package:laundry/features/auth/data/models/auth_models.dart';

abstract class AuthLocalDataSource {
  Future<void> persistSession(AuthResponseModel response);
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorageService _localStorageService;

  AuthLocalDataSourceImpl({required LocalStorageService localStorageService})
    : _localStorageService = localStorageService;

  @override
  Future<void> persistSession(AuthResponseModel response) async {
    await _localStorageService.saveToken(response.token);
    await _localStorageService.setLoggedIn(true);
  }

  @override
  Future<void> clearSession() async {
    await _localStorageService.setLoggedIn(false);
    await _localStorageService.clearToken();
  }
}
