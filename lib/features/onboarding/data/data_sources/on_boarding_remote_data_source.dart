import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/on_boarding_model.dart';

abstract class OnBoardingRemoteDataSource {
  Future<List<OnBoardingModel>> getOnboardingData();
}

class OnBoardingRemoteDataSourceImpl implements OnBoardingRemoteDataSource {
  final ApiClient _apiClient;

  OnBoardingRemoteDataSourceImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<OnBoardingModel>> getOnboardingData() async {
    final response = await _apiClient.get(ApiConstants.onboarding);
    final List<dynamic> data = response.data['data'];
    return data.map((json) => OnBoardingModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}
