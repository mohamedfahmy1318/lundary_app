import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:laundry/features/onboarding/domain/usecases/get_on_boarding_slides_usecase.dart';

import 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final GetOnBoardingSlidesUseCase _getOnBoardingSlidesUseCase;

  OnBoardingCubit({
    required GetOnBoardingSlidesUseCase getOnBoardingSlidesUseCase,
  }) : _getOnBoardingSlidesUseCase = getOnBoardingSlidesUseCase,
       super(const OnBoardingState.initial());

  Future<void> loadOnBoarding() async {
    emit(const OnBoardingState.loading());
    final result = await _getOnBoardingSlidesUseCase();

    result.fold(
      (failure) => emit(OnBoardingState.error(failure.message)),
      (slides) => emit(OnBoardingState.loaded(slides: slides)),
    );
  }
}
