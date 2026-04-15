import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/entities/ticket_entity.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class CloseTicketParams extends Equatable {
  final int ticketId;

  const CloseTicketParams({required this.ticketId});

  @override
  List<Object?> get props => [ticketId];
}

class CloseTicketUseCase {
  final ProfileRepo _profileRepo;

  const CloseTicketUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, TicketEntity>> call(CloseTicketParams params) {
    return _profileRepo.closeTicket(params.ticketId);
  }
}
