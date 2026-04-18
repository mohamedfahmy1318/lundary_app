import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/entities/subscription_checkout_entity.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class SubscribeToPlanParams extends Equatable {
  final int planId;

  const SubscribeToPlanParams({required this.planId});

  @override
  List<Object?> get props => [planId];
}

class SubscribeToPlanUseCase {
  final ProfileRepo _profileRepo;

  const SubscribeToPlanUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, SubscriptionCheckoutEntity>> call(
    SubscribeToPlanParams params,
  ) {
    return _profileRepo.subscribeToPlan(params.planId);
  }
}
