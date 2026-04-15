import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/features/basket/domain/usecases/get_timeslots_usecase.dart';
import 'package:laundry/features/basket/presentation/cubit/timeslots_state.dart';

class TimeslotsCubit extends Cubit<TimeslotsState> {
  final GetTimeslotsUseCase _getTimeslotsUseCase;

  TimeslotsCubit({required GetTimeslotsUseCase getTimeslotsUseCase})
    : _getTimeslotsUseCase = getTimeslotsUseCase,
      super(const TimeslotsState.initial());

  Future<void> fetchTimeslots(String date) async {
    emit(const TimeslotsState.loading());
    final result = await _getTimeslotsUseCase(GetTimeslotsParams(date: date));

    result.fold(
      (failure) => emit(TimeslotsState.error(failure.message)),
      (slots) => emit(TimeslotsState.loaded(slots)),
    );
  }
}
