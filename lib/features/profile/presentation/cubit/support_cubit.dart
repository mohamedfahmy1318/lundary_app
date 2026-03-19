import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';
import 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  final ProfileRepo _repo;

  SupportCubit({required ProfileRepo repo})
    : _repo = repo,
      super(const SupportState.initial());

  Future<void> loadTickets() async {
    emit(const SupportState.loading());
    final result = await _repo.getTickets();
    result.fold(
      (failure) => emit(SupportState.error(failure.message)),
      (tickets) => emit(SupportState.loaded(tickets: tickets)),
    );
  }

  Future<void> createTicket(String subject, String message, String priority, String category) async {
    emit(const SupportState.submitting());

    final ticketData = {
      "subject": subject,
      "message": message,
      "priority": priority,
      "category": category,
    };

    final result = await _repo.createTicket(ticketData);
    result.fold(
      (failure) {
        emit(SupportState.error(failure.message));
        loadTickets(); // Fallback to reload after error display
      },
      (_) {
        emit(const SupportState.submissionSuccess());
        loadTickets(); // Refresh list automatically
      },
    );
  }
}
