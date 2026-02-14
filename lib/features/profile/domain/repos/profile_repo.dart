import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/data/models/ticket_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, Map<String, dynamic>>> getProfile();
  Future<Either<Failure, void>> updateProfile(Map<String, dynamic> data);
  Future<Either<Failure, List<TicketModel>>> getTickets();
  Future<Either<Failure, void>> createTicket(Map<String, dynamic> ticketData);
  Future<Either<Failure, List<Map<String, dynamic>>>> getSubscriptionPlans();
  Future<Either<Failure, void>> deleteAccount();
  Future<Either<Failure, void>> logout();
}
