import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/features/profile/data/data_sources/profile_local_data_source.dart';
import 'package:laundry/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:laundry/features/profile/data/models/profile_model.dart';
import 'package:laundry/features/profile/data/models/ticket_model.dart';
import 'package:laundry/features/profile/domain/entities/active_subscription_entity.dart';
import 'package:laundry/features/profile/domain/entities/profile_entity.dart';
import 'package:laundry/features/profile/domain/entities/subscription_checkout_entity.dart';
import 'package:laundry/features/profile/domain/entities/subscription_plan_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_lookup_option_entity.dart';
import 'package:laundry/features/profile/domain/entities/ticket_reply_entity.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource _remoteDataSource;
  final ProfileLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  ProfileRepoImpl({
    required ProfileRemoteDataSource remoteDataSource,
    required ProfileLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final profile = await _remoteDataSource.getProfile();
        await _localDataSource.cacheProfile(profile);
        return Right(profile);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedProfile();
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedProfile();
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedProfile();
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, void>> updateProfile({
    String? name,
    String? phone,
    String? avatarFilePath,
    List<String>? addresses,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      await _remoteDataSource.updateProfile(
        name: name,
        phone: phone,
        avatarFilePath: avatarFilePath,
        addresses: addresses,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      await _remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TicketEntity>>> getTickets() async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final tickets = await _remoteDataSource.getTickets();
        await _localDataSource.cacheTickets(tickets);
        for (final ticket in tickets) {
          await _localDataSource.cacheTicket(ticket);
        }
        return Right(tickets);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedTickets();
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedTickets();
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedTickets();
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, TicketEntity>> getTicketDetails(int ticketId) async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final ticket = await _remoteDataSource.getTicketDetails(ticketId);
        await _localDataSource.cacheTicket(ticket);
        return Right(ticket);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedTicket(ticketId);
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedTicket(ticketId);
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedTicket(ticketId);
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, TicketReplyEntity>> replyToTicket({
    required int ticketId,
    required String message,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      final reply = await _remoteDataSource.replyToTicket(ticketId, message);
      final cachedTicket = await _tryGetCachedTicket(ticketId);
      if (cachedTicket != null) {
        final updated = cachedTicket.copyWith(
          replies: <TicketReplyModel>[...?cachedTicket.replies, reply],
          updatedAt: reply.updatedAt,
        );
        await _localDataSource.cacheTicket(updated);
      }
      return Right(reply);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TicketEntity>> closeTicket(int ticketId) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      final ticket = await _remoteDataSource.closeTicket(ticketId);
      await _localDataSource.cacheTicket(ticket);
      return Right(ticket);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createTicket({
    required String subject,
    required String message,
    required String priority,
    required String category,
  }) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      await _remoteDataSource.createTicket(
        subject: subject,
        message: message,
        priority: priority,
        category: category,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TicketLookupOptionEntity>>>
  getTicketCategories() async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final categories = await _remoteDataSource.getTicketCategories();
        await _localDataSource.cacheTicketCategories(categories);
        return Right(categories);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedTicketCategories();
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedTicketCategories();
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedTicketCategories();
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, List<TicketLookupOptionEntity>>>
  getTicketPriorities() async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final priorities = await _remoteDataSource.getTicketPriorities();
        await _localDataSource.cacheTicketPriorities(priorities);
        return Right(priorities);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedTicketPriorities();
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedTicketPriorities();
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedTicketPriorities();
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, List<TicketLookupOptionEntity>>>
  getTicketStatuses() async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final statuses = await _remoteDataSource.getTicketStatuses();
        await _localDataSource.cacheTicketStatuses(statuses);
        return Right(statuses);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedTicketStatuses();
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedTicketStatuses();
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedTicketStatuses();
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, List<SubscriptionPlanEntity>>>
  getSubscriptionPlans() async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final plans = await _remoteDataSource.getSubscriptionPlans();
        await _localDataSource.cacheSubscriptionPlans(plans);
        return Right(plans);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedSubscriptionPlans();
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedSubscriptionPlans();
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedSubscriptionPlans();
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, List<ActiveSubscriptionEntity>>>
  getMySubscriptions() async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final subscriptions = await _remoteDataSource.getMySubscriptions();
        await _localDataSource.cacheMySubscriptions(subscriptions);
        return Right(subscriptions);
      } on ServerException catch (e) {
        final cached = await _tryGetCachedMySubscriptions();
        if (cached != null) {
          return Right(cached);
        }
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } catch (e) {
        final cached = await _tryGetCachedMySubscriptions();
        if (cached != null) {
          return Right(cached);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cached = await _tryGetCachedMySubscriptions();
    if (cached != null) {
      return Right(cached);
    }

    return const Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, SubscriptionCheckoutEntity>> subscribeToPlan(
    int planId,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      final result = await _remoteDataSource.subscribeToPlan(planId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      await _remoteDataSource.deleteAccount();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      await _remoteDataSource.logout();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  Future<ProfileModel?> _tryGetCachedProfile() async {
    try {
      return await _localDataSource.getCachedProfile();
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<List<TicketModel>?> _tryGetCachedTickets() async {
    try {
      return await _localDataSource.getCachedTickets();
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<TicketModel?> _tryGetCachedTicket(int ticketId) async {
    try {
      return await _localDataSource.getCachedTicketDetails(ticketId);
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<List<TicketLookupOptionModel>?> _tryGetCachedTicketCategories() async {
    try {
      return await _localDataSource.getCachedTicketCategories();
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<List<TicketLookupOptionModel>?> _tryGetCachedTicketPriorities() async {
    try {
      return await _localDataSource.getCachedTicketPriorities();
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<List<TicketLookupOptionModel>?> _tryGetCachedTicketStatuses() async {
    try {
      return await _localDataSource.getCachedTicketStatuses();
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<List<SubscriptionPlanModel>?> _tryGetCachedSubscriptionPlans() async {
    try {
      return await _localDataSource.getCachedSubscriptionPlans();
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }

  Future<List<ActiveSubscriptionModel>?> _tryGetCachedMySubscriptions() async {
    try {
      return await _localDataSource.getCachedMySubscriptions();
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
