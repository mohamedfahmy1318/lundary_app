import 'package:laundry/features/basket/data/models/time_slot_model.dart';

abstract class BasketLocalDataSource {
  List<TimeSlotModel>? getCachedTimeslots(String date);
  Future<void> cacheTimeslots(String date, List<TimeSlotModel> timeslots);
}

class BasketLocalDataSourceImpl implements BasketLocalDataSource {
  final Map<String, List<TimeSlotModel>> _timeslotsByDate = {};

  @override
  List<TimeSlotModel>? getCachedTimeslots(String date) {
    final cached = _timeslotsByDate[date];
    if (cached == null) {
      return null;
    }
    return List<TimeSlotModel>.unmodifiable(cached);
  }

  @override
  Future<void> cacheTimeslots(
    String date,
    List<TimeSlotModel> timeslots,
  ) async {
    _timeslotsByDate[date] = List<TimeSlotModel>.from(timeslots);
  }
}
