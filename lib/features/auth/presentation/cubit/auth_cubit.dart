import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/auth/data/models/auth_models.dart';
import 'package:laundry/features/auth/domain/repos/auth_repo.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    emit(const AuthState.loading());
    final result = await _authRepo.login(
      LoginRequestModel(email: email, password: password),
    );
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (response) => emit(AuthState.authenticated(response)),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(const AuthState.loading());
    final result = await _authRepo.register(
      RegisterRequestModel(
        name: name,
        email: email,
        password: password,
        phone: phone,
      ),
    );
    result.fold(
      (failure) => emit(AuthState.error(failure.message)),
      (response) => emit(AuthState.authenticated(response)),
    );
  }
}
