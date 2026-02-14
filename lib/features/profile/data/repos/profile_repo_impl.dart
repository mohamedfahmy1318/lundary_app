import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:laundry/features/profile/data/models/ticket_model.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ProfileRepoImpl({
    required ProfileRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, Map<String, dynamic>>> getProfile() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final data = await _remoteDataSource.getProfile();
      return Right(data);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(Map<String, dynamic> data) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      await _remoteDataSource.updateProfile(data);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<TicketModel>>> getTickets() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final tickets = await _remoteDataSource.getTickets();
      return Right(tickets);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> createTicket(
    Map<String, dynamic> ticketData,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      await _remoteDataSource.createTicket(ticketData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>>
  getSubscriptionPlans() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final plans = await _remoteDataSource.getSubscriptionPlans();
      return Right(plans);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
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
      return Left(ServerFailure(message: e.message));
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
      return Left(ServerFailure(message: e.message));
    }
  }
}
