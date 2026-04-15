abstract class TimeSlotEntity {
  const TimeSlotEntity();

  String get id;
  String get startTime;
  String get endTime;
  String get type;
  String get maxOrders;
  String get availableDays;
  bool get isActive;

  bool supportsDay(String dayName) {
    final normalizedDay = dayName.trim().toLowerCase();
    if (normalizedDay.isEmpty) {
      return false;
    }

    return availableDays
        .split(',')
        .map((day) => day.trim().toLowerCase())
        .where((day) => day.isNotEmpty)
        .any((day) => day == normalizedDay);
  }

  bool supportsPickupType() => type == 'pickup' || type == 'pickup_delivery';

  bool supportsDeliveryType() =>
      type == 'delivery' || type == 'pickup_delivery';
}
