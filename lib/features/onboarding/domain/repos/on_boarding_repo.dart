import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/on_boarding_model.dart';

abstract class OnBoardingRepo {
  Future<Either<Failure, List<OnBoardingModel>>> getOnboardingData();
}
