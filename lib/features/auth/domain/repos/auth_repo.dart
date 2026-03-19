import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/auth/data/models/auth_models.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthResponseModel>> login(
    LoginRequestModel loginRequest,
  );
  Future<Either<Failure, AuthResponseModel>> register(
    RegisterRequestModel registerRequest,
  );
  Future<Either<Failure, void>> logout();
}
