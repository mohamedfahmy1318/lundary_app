import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import 'package:laundry/features/onboarding/domain/entities/on_boarding_slide_entity.dart';

abstract class OnBoardingRepo {
  Future<Either<Failure, List<OnBoardingSlideEntity>>> getOnboardingData();
}
