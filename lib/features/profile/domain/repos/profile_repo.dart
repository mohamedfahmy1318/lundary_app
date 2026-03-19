import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/data/models/profile_model.dart';
import 'package:laundry/features/profile/data/models/ticket_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getProfile();
  Future<Either<Failure, void>> updateProfile({String? name, String? phone, String? avatarFilePath});
  Future<Either<Failure, void>> changePassword(Map<String, dynamic> data);
  Future<Either<Failure, List<TicketModel>>> getTickets();
  Future<Either<Failure, void>> createTicket(Map<String, dynamic> ticketData);
  Future<Either<Failure, List<SubscriptionPlan>>> getSubscriptionPlans();
  Future<Either<Failure, List<ActiveSubscription>>> getMySubscriptions();
  Future<Either<Failure, void>> deleteAccount();
  Future<Either<Failure, void>> logout();
}
