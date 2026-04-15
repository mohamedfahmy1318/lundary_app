import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/features/onboarding/data/models/on_boarding_model.dart';

abstract class OnBoardingLocalDataSource {
  Future<void> cacheSlides(List<OnBoardingModel> slides);
  Future<List<OnBoardingModel>> getCachedSlides();
}

class OnBoardingLocalDataSourceImpl implements OnBoardingLocalDataSource {
  List<OnBoardingModel> _cachedSlides = const <OnBoardingModel>[];

  @override
  Future<void> cacheSlides(List<OnBoardingModel> slides) async {
    _cachedSlides = List<OnBoardingModel>.unmodifiable(slides);
  }

  @override
  Future<List<OnBoardingModel>> getCachedSlides() async {
    if (_cachedSlides.isEmpty) {
      throw const CacheException(message: 'No cached onboarding data found.');
    }
    return _cachedSlides;
  }
}
