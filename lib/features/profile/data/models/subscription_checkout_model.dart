import 'package:laundry/features/profile/domain/entities/subscription_checkout_entity.dart';

class SubscriptionCheckoutModel extends SubscriptionCheckoutEntity {
  @override
  final int planId;
  @override
  final int? subscriptionId;
  @override
  final String message;
  @override
  final String? paymentUrl;
  @override
  final bool activated;

  const SubscriptionCheckoutModel({
    required this.planId,
    required this.message,
    required this.activated,
    this.subscriptionId,
    this.paymentUrl,
  });

  factory SubscriptionCheckoutModel.fromJson(
    Map<String, dynamic> json, {
    required int planId,
  }) {
    final data = _extractMap(json['data']);
    final subscription = _extractMap(data?['subscription']);

    final paymentUrl =
        _parseString(data?['payment_url']) ?? _parseString(json['payment_url']);
    final status =
        _parseString(data?['status']) ?? _parseString(subscription?['status']);
    final activated =
        paymentUrl == null &&
        (_parseBool(data?['activated']) ||
            status == 'active' ||
            status == 'paid');

    return SubscriptionCheckoutModel(
      planId: planId,
      subscriptionId:
          _parseInt(data?['subscription_id']) ??
          _parseInt(subscription?['id']) ??
          _parseInt(json['subscription_id']),
      message:
          _parseString(json['message']) ??
          _parseString(data?['message']) ??
          'Subscription checkout created successfully.',
      paymentUrl: paymentUrl,
      activated: activated,
    );
  }
}

Map<String, dynamic>? _extractMap(Object? value) {
  if (value is Map<String, dynamic>) {
    return value;
  }
  if (value is Map) {
    return Map<String, dynamic>.from(value);
  }
  return null;
}

int? _parseInt(Object? value) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  return int.tryParse(value?.toString() ?? '');
}

String? _parseString(Object? value) {
  final parsed = value?.toString();
  if (parsed == null || parsed.trim().isEmpty || parsed == 'null') {
    return null;
  }
  return parsed;
}

bool _parseBool(Object? value) {
  if (value is bool) {
    return value;
  }
  final normalized = value?.toString().trim().toLowerCase();
  return normalized == '1' || normalized == 'true' || normalized == 'yes';
}
