import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/core/services/local_storage_service.dart';
import 'package:laundry/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:laundry/features/auth/data/models/auth_models.dart';
import 'package:laundry/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final LocalStorageService _localStorageService;

  AuthRepoImpl({
    required AuthRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
    required LocalStorageService localStorageService,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo,
       _localStorageService = localStorageService;

  @override
  Future<Either<Failure, AuthResponseModel>> login(
    LoginRequestModel loginRequest,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final response = await _remoteDataSource.login(loginRequest);
      await _localStorageService.saveToken(response.token);
      await _localStorageService.setLoggedIn(true);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> register(
    RegisterRequestModel registerRequest,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final response = await _remoteDataSource.register(registerRequest);
      await _localStorageService.saveToken(response.token);
      await _localStorageService.setLoggedIn(true);
      return Right(response);
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
      await _localStorageService.setLoggedIn(false);
      await _localStorageService.clearToken();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
