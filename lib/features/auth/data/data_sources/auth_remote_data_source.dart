import 'package:laundry/core/constants/api_constants.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/features/auth/data/models/auth_models.dart';

abstract class AuthRemoteDataSource {
  Future<OtpChallengeModel> registerRequest(
    RegisterRequestModel registerRequest,
  );
  Future<AuthResponseModel> registerVerify(VerifyOtpRequestModel verifyRequest);
  Future<OtpChallengeModel> loginRequest(LoginRequestModel loginRequest);
  Future<AuthResponseModel> loginVerify(LoginVerifyRequestModel verifyRequest);
  Future<AuthResponseModel> socialLogin(
    SocialLoginRequestModel socialLoginRequest,
  );
  Future<OtpChallengeModel> resendOtp(ResendOtpRequestModel resendRequest);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<OtpChallengeModel> registerRequest(
    RegisterRequestModel registerRequest,
  ) async {
    final response = await _apiClient.post(
      ApiConstants.registerRequest,
      data: registerRequest.toJson(),
    );
    return OtpChallengeModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthResponseModel> registerVerify(
    VerifyOtpRequestModel verifyRequest,
  ) async {
    final response = await _apiClient.post(
      ApiConstants.registerVerify,
      data: verifyRequest.toJson(),
    );
    return AuthResponseModel.fromJson(response.data['data']);
  }

  @override
  Future<OtpChallengeModel> loginRequest(LoginRequestModel loginRequest) async {
    final response = await _apiClient.post(
      ApiConstants.loginRequest,
      data: loginRequest.toJson(),
    );
    return OtpChallengeModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<AuthResponseModel> loginVerify(
    LoginVerifyRequestModel verifyRequest,
  ) async {
    final response = await _apiClient.post(
      ApiConstants.loginVerify,
      data: verifyRequest.toJson(),
    );
    return AuthResponseModel.fromJson(response.data['data']);
  }

  @override
  Future<AuthResponseModel> socialLogin(
    SocialLoginRequestModel socialLoginRequest,
  ) async {
    final response = await _apiClient.post(
      ApiConstants.socialAuth,
      data: socialLoginRequest.toJson(),
    );
    return AuthResponseModel.fromJson(response.data['data']);
  }

  @override
  Future<OtpChallengeModel> resendOtp(
    ResendOtpRequestModel resendRequest,
  ) async {
    final response = await _apiClient.post(
      ApiConstants.resendOtp,
      data: resendRequest.toJson(),
    );
    return OtpChallengeModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    await _apiClient.post(ApiConstants.logout);
  }
}
