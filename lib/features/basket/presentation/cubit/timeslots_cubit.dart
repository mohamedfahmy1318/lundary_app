import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/basket/domain/repos/basket_repo.dart';
import 'package:laundry/features/basket/presentation/cubit/timeslots_state.dart';

class TimeslotsCubit extends Cubit<TimeslotsState> {
  final BasketRepo _basketRepo;

  TimeslotsCubit({required BasketRepo basketRepo})
      : _basketRepo = basketRepo,
        super(const TimeslotsState.initial());

  Future<void> fetchTimeslots(String date) async {
    emit(const TimeslotsState.loading());
    final result = await _basketRepo.getTimeslots(date);

    result.fold(
      (failure) => emit(TimeslotsState.error(failure.message)),
      (slots) => emit(TimeslotsState.loaded(slots)),
    );
  }
}
