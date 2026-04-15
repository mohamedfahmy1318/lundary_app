import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/entities/active_subscription_entity.dart';
import 'package:laundry/features/profile/domain/entities/profile_entity.dart';
import 'package:laundry/features/profile/domain/entities/subscription_plan_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_lookup_option_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_reply_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileEntity>> getProfile();
  Future<Either<Failure, void>> updateProfile({
    String? name,
    String? phone,
    String? avatarFilePath,
  });
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
  Future<Either<Failure, List<TicketEntity>>> getTickets();
  Future<Either<Failure, TicketEntity>> getTicketDetails(int ticketId);
  Future<Either<Failure, TicketReplyEntity>> replyToTicket({
    required int ticketId,
    required String message,
  });
  Future<Either<Failure, TicketEntity>> closeTicket(int ticketId);
  Future<Either<Failure, void>> createTicket({
    required String subject,
    required String message,
    required String priority,
    required String category,
  });
  Future<Either<Failure, List<TicketLookupOptionEntity>>> getTicketCategories();
  Future<Either<Failure, List<TicketLookupOptionEntity>>> getTicketPriorities();
  Future<Either<Failure, List<TicketLookupOptionEntity>>> getTicketStatuses();
  Future<Either<Failure, List<SubscriptionPlanEntity>>> getSubscriptionPlans();
  Future<Either<Failure, List<ActiveSubscriptionEntity>>> getMySubscriptions();
  Future<Either<Failure, void>> deleteAccount();
  Future<Either<Failure, void>> logout();
}
