import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/auth/domain/repos/auth_repo.dart';

class LogoutAuthUseCase {
  final AuthRepo _authRepo;

  const LogoutAuthUseCase({required AuthRepo authRepo}) : _authRepo = authRepo;

  Future<Either<Failure, void>> call() {
    return _authRepo.logout();
  }
}
