import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/entities/ticket_entity.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class GetTicketDetailsParams extends Equatable {
  final int ticketId;

  const GetTicketDetailsParams({required this.ticketId});

  @override
  List<Object?> get props => [ticketId];
}

class GetTicketDetailsUseCase {
  final ProfileRepo _profileRepo;

  const GetTicketDetailsUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, TicketEntity>> call(GetTicketDetailsParams params) {
    return _profileRepo.getTicketDetails(params.ticketId);
  }
}
