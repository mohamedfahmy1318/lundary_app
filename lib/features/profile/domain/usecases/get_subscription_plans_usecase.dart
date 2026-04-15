import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/entities/subscription_plan_entity.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class GetSubscriptionPlansUseCase {
  final ProfileRepo _profileRepo;

  const GetSubscriptionPlansUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, List<SubscriptionPlanEntity>>> call() {
    return _profileRepo.getSubscriptionPlans();
  }
}
