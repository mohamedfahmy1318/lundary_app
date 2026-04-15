import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/profile/domain/entities/ticket_lookup_option_entity.dart';
import 'package:laundry/features/profile/domain/usecases/create_ticket_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_ticket_categories_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_ticket_priorities_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_ticket_statuses_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_tickets_usecase.dart';
import 'support_state.dart';

class TicketLookups {
  final List<TicketLookupOptionEntity> categories;
  final List<TicketLookupOptionEntity> priorities;
  final List<TicketLookupOptionEntity> statuses;

  const TicketLookups({
    required this.categories,
    required this.priorities,
    required this.statuses,
  });
}

class SupportCubit extends Cubit<SupportState> {
  final GetTicketsUseCase _getTicketsUseCase;
  final GetTicketCategoriesUseCase _getTicketCategoriesUseCase;
  final GetTicketPrioritiesUseCase _getTicketPrioritiesUseCase;
  final GetTicketStatusesUseCase _getTicketStatusesUseCase;
  final CreateTicketUseCase _createTicketUseCase;

  SupportCubit({
    required GetTicketsUseCase getTicketsUseCase,
    required GetTicketCategoriesUseCase getTicketCategoriesUseCase,
    required GetTicketPrioritiesUseCase getTicketPrioritiesUseCase,
    required GetTicketStatusesUseCase getTicketStatusesUseCase,
    required CreateTicketUseCase createTicketUseCase,
  }) : _getTicketsUseCase = getTicketsUseCase,
       _getTicketCategoriesUseCase = getTicketCategoriesUseCase,
       _getTicketPrioritiesUseCase = getTicketPrioritiesUseCase,
       _getTicketStatusesUseCase = getTicketStatusesUseCase,
       _createTicketUseCase = createTicketUseCase,
       super(const SupportState.initial());

  Future<void> loadTickets() async {
    emit(const SupportState.loading());
    final result = await _getTicketsUseCase();
    result.fold(
      (failure) => emit(SupportState.error(failure.message)),
      (tickets) => emit(SupportState.loaded(tickets: tickets)),
    );
  }

  Future<TicketLookups?> loadTicketLookups() async {
    final lookupResults =
        await Future.wait<Either<Failure, List<TicketLookupOptionEntity>>>([
          _getTicketCategoriesUseCase(),
          _getTicketPrioritiesUseCase(),
          _getTicketStatusesUseCase(),
        ]);

    final categories = _lookupOptionsOrNull(lookupResults[0]);
    final priorities = _lookupOptionsOrNull(lookupResults[1]);
    final statuses = _lookupOptionsOrNull(lookupResults[2]);

    if (categories == null || priorities == null || statuses == null) {
      return null;
    }

    return TicketLookups(
      categories: categories,
      priorities: priorities,
      statuses: statuses,
    );
  }

  Future<List<TicketLookupOptionEntity>> loadTicketStatuses() async {
    final result = await _getTicketStatusesUseCase();
    return _lookupOptionsOrEmpty(result);
  }

  Future<void> createTicket({
    required String subject,
    required String message,
    required String priority,
    required String category,
  }) async {
    emit(const SupportState.submitting());

    final result = await _createTicketUseCase(
      CreateTicketParams(
        subject: subject,
        message: message,
        priority: priority,
        category: category,
      ),
    );
    result.fold(
      (failure) => emit(SupportState.error(failure.message)),
      (_) => emit(const SupportState.submissionSuccess()),
    );
  }

  List<TicketLookupOptionEntity>? _lookupOptionsOrNull(
    Either<Failure, List<TicketLookupOptionEntity>> result,
  ) {
    return result.fold((_) => null, (data) => data);
  }

  List<TicketLookupOptionEntity> _lookupOptionsOrEmpty(
    Either<Failure, List<TicketLookupOptionEntity>> result,
  ) {
    return result.fold((_) => const [], (data) => data);
  }
}
