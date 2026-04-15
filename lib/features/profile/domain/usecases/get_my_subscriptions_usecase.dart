import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/entities/active_subscription_entity.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class GetMySubscriptionsUseCase {
  final ProfileRepo _profileRepo;

  const GetMySubscriptionsUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, List<ActiveSubscriptionEntity>>> call() {
    return _profileRepo.getMySubscriptions();
  }
}
