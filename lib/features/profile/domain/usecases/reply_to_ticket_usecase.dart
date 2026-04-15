import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/entities/ticket_reply_entity.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class ReplyToTicketParams extends Equatable {
  final int ticketId;
  final String message;

  const ReplyToTicketParams({required this.ticketId, required this.message});

  @override
  List<Object?> get props => [ticketId, message];
}

class ReplyToTicketUseCase {
  final ProfileRepo _profileRepo;

  const ReplyToTicketUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, TicketReplyEntity>> call(ReplyToTicketParams params) {
    return _profileRepo.replyToTicket(
      ticketId: params.ticketId,
      message: params.message,
    );
  }
}
