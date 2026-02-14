import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/auth/data/models/auth_models.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(LoginRequestModel loginRequest);
  Future<AuthResponseModel> register(RegisterRequestModel registerRequest);
  // Add verify and resend if API exists, for now placeholders or implementation depends on specific API docs which I don't have fully yet.
  // Assuming standard implementation:
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<AuthResponseModel> login(LoginRequestModel loginRequest) async {
    final response = await _apiClient.post(
      ApiConstants.login, // Ensure this constant exists or add it
      data: loginRequest.toJson(),
    );
    return AuthResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthResponseModel> register(
    RegisterRequestModel registerRequest,
  ) async {
    final response = await _apiClient.post(
      ApiConstants.register, // Ensure this constant exists or add it
      data: registerRequest.toJson(),
    );
    return AuthResponseModel.fromJson(response.data);
  }
}
