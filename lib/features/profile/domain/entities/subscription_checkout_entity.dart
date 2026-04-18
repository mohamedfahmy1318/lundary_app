abstract class SubscriptionCheckoutEntity {
  const SubscriptionCheckoutEntity();

  int get planId;
  int? get subscriptionId;
  String get message;
  String? get paymentUrl;
  bool get activated;
}
