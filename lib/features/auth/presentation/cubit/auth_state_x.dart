import 'package:laundry/features/auth/presentation/cubit/auth_state.dart';

extension AuthStateX on AuthState {
  bool get isLoading {
    return maybeWhen(loading: () => true, orElse: () => false);
  }
}
