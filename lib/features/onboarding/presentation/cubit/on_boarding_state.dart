import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry/features/onboarding/domain/entities/on_boarding_slide_entity.dart';

part 'on_boarding_state.freezed.dart';

@freezed
class OnBoardingState with _$OnBoardingState {
  const factory OnBoardingState.initial() = _Initial;
  const factory OnBoardingState.loading() = _Loading;
  const factory OnBoardingState.loaded({
    required List<OnBoardingSlideEntity> slides,
  }) = _Loaded;
  const factory OnBoardingState.error(String message) = _Error;
}
