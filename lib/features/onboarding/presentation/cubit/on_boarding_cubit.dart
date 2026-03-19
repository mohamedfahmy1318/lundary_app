import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repos/on_boarding_repo.dart';
import 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final OnBoardingRepo _repo;

  OnBoardingCubit({required OnBoardingRepo repo})
      : _repo = repo,
        super(const OnBoardingState.initial());

  Future<void> loadOnBoarding() async {
    emit(const OnBoardingState.loading());
    final result = await _repo.getOnboardingData();

    result.fold(
      (failure) => emit(OnBoardingState.error(failure.message)),
      (slides) => emit(OnBoardingState.loaded(slides: slides)),
    );
  }
}
