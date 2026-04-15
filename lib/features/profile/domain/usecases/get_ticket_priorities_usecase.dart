import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/entities/ticket_lookup_option_entity.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class GetTicketPrioritiesUseCase {
  final ProfileRepo _profileRepo;

  const GetTicketPrioritiesUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, List<TicketLookupOptionEntity>>> call() {
    return _profileRepo.getTicketPriorities();
  }
}
