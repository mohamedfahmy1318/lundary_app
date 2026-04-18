import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:laundry/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:laundry/features/auth/data/models/auth_models.dart';
import 'package:laundry/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:laundry/features/auth/domain/entities/auth_response_entity.dart';
import 'package:laundry/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  AuthRepoImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, AuthOtpChallengeEntity>> requestRegisterOtp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    return _performRequest(
      () => _remoteDataSource.registerRequest(
        RegisterRequestModel(
          name: name,
          email: email,
          password: password,
          phone: phone,
          passwordConfirmation: password,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> verifyRegisterOtp({
    required String email,
    required String otp,
  }) async {
    return _performRequest(() async {
      final response = await _remoteDataSource.registerVerify(
        VerifyOtpRequestModel(email: email, otp: otp),
      );
      await _localDataSource.persistSession(response);
      return response;
    });
  }

  @override
  Future<Either<Failure, AuthOtpChallengeEntity>> requestLoginOtp({
    required String email,
    required String password,
  }) async {
    return _performRequest(
      () => _remoteDataSource.loginRequest(
        LoginRequestModel(email: email, password: password),
      ),
    );
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> verifyLoginOtp({
    required String email,
    required String otp,
    String fcmToken = '',
  }) async {
    return _performRequest(() async {
      final response = await _remoteDataSource.loginVerify(
        LoginVerifyRequestModel(email: email, otp: otp, fcmToken: fcmToken),
      );
      await _localDataSource.persistSession(response);
      return response;
    });
  }

  @override
  Future<Either<Failure, AuthResponseEntity>> socialLogin({
    required String firebaseToken,
    String fcmToken = '',
    required String deviceType,
  }) async {
    return _performRequest(() async {
      final response = await _remoteDataSource.socialLogin(
        SocialLoginRequestModel(
          firebaseToken: firebaseToken,
          fcmToken: fcmToken,
          deviceType: deviceType,
        ),
      );
      await _localDataSource.persistSession(response);
      return response;
    });
  }

  @override
  Future<Either<Failure, AuthOtpChallengeEntity>> resendOtp({
    required String email,
  }) async {
    return _performRequest(
      () => _remoteDataSource.resendOtp(ResendOtpRequestModel(email: email)),
    );
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return _performRequest(() async {
      await _remoteDataSource.logout();
      await _localDataSource.clearSession();
    });
  }

  Future<Either<Failure, T>> _performRequest<T>(
    Future<T> Function() request,
  ) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }

    try {
      final result = await request();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
