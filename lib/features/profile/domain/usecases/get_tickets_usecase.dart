import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/entities/ticket_entity.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class GetTicketsUseCase {
  final ProfileRepo _profileRepo;

  const GetTicketsUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, List<TicketEntity>>> call() {
    return _profileRepo.getTickets();
  }
}
