abstract class SubscriptionPlanEntity {
  const SubscriptionPlanEntity();

  int get id;
  String get name;
  String get slug;
  String? get description;
  String get price;
  int get durationDays;
  int get itemLimit;
  bool get unlimitedItems;
  bool get freeDelivery;
  bool get expressService;
  bool get prioritySupport;
  int get discountPercentage;
  bool get isActive;
}
