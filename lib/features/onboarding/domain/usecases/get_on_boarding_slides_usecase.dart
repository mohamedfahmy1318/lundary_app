import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/onboarding/domain/entities/on_boarding_slide_entity.dart';
import 'package:laundry/features/onboarding/domain/repos/on_boarding_repo.dart';

class GetOnBoardingSlidesUseCase {
  final OnBoardingRepo _onBoardingRepo;

  const GetOnBoardingSlidesUseCase({required OnBoardingRepo onBoardingRepo})
    : _onBoardingRepo = onBoardingRepo;

  Future<Either<Failure, List<OnBoardingSlideEntity>>> call() {
    return _onBoardingRepo.getOnboardingData();
  }
}
