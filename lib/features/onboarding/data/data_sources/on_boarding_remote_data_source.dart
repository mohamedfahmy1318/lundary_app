import '../../../../core/network/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/on_boarding_model.dart';

abstract class OnBoardingRemoteDataSource {
  Future<List<OnBoardingModel>> getOnboardingData();
}

class OnBoardingRemoteDataSourceImpl implements OnBoardingRemoteDataSource {
  final ApiClient _apiClient;

  OnBoardingRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<OnBoardingModel>> getOnboardingData() async {
    final response = await _apiClient.get(ApiConstants.onboarding);
    final payload = response.data;
    final source =
        payload is Map<String, dynamic>
            ? payload['data']
            : (payload is Map ? payload['data'] : payload);

    final data = source is List ? source : const <dynamic>[];
    return data
        .whereType<Map>()
        .map(
          (json) => OnBoardingModel.fromJson(Map<String, dynamic>.from(json)),
        )
        .toList();
  }
}
