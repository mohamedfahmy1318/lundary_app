import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/on_boarding_model.dart';

part 'on_boarding_state.freezed.dart';

@freezed
class OnBoardingState with _$OnBoardingState {
  const factory OnBoardingState.initial() = _Initial;
  const factory OnBoardingState.loading() = _Loading;
  const factory OnBoardingState.loaded({
    required List<OnBoardingModel> slides,
  }) = _Loaded;
  const factory OnBoardingState.error(String message) = _Error;
}
