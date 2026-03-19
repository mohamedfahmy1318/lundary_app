import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/auth/data/models/auth_models.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequestModel loginRequest);
  Future<AuthResponseModel> register(RegisterRequestModel registerRequest);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<AuthResponseModel> login(LoginRequestModel loginRequest) async {
    final response = await _apiClient.post(
      ApiConstants.login,
      data: loginRequest.toJson(),
    );
    return AuthResponseModel.fromJson(response.data['data']);
  }

  @override
  Future<AuthResponseModel> register(
    RegisterRequestModel registerRequest,
  ) async {
    final response = await _apiClient.post(
      ApiConstants.register,
      data: registerRequest.toJson(),
    );
    return AuthResponseModel.fromJson(response.data['data']);
  }

  @override
  Future<void> logout() async {
    await _apiClient.post(ApiConstants.logout);
  }
}
