import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class CreateTicketParams extends Equatable {
  final String subject;
  final String message;
  final String priority;
  final String category;

  const CreateTicketParams({
    required this.subject,
    required this.message,
    required this.priority,
    required this.category,
  });

  @override
  List<Object?> get props => [subject, message, priority, category];
}

class CreateTicketUseCase {
  final ProfileRepo _profileRepo;

  const CreateTicketUseCase({required ProfileRepo profileRepo})
    : _profileRepo = profileRepo;

  Future<Either<Failure, void>> call(CreateTicketParams params) {
    return _profileRepo.createTicket(
      subject: params.subject,
      message: params.message,
      priority: params.priority,
      category: params.category,
    );
  }
}
