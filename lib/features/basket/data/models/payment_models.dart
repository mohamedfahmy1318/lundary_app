import 'package:laundry/features/basket/domain/entities/payment_initiation_entity.dart';
import 'package:laundry/features/basket/domain/entities/payment_status_entity.dart';

class PaymentInitiationModel extends PaymentInitiationEntity {
  @override
  final String paymentUrl;
  @override
  final String? orderRef;

  const PaymentInitiationModel({required this.paymentUrl, this.orderRef});

  factory PaymentInitiationModel.fromJson(Map<String, dynamic> json) {
    final data = _extractMap(json['data']);
    final paymentUrl =
        _asString(json['payment_url']) ?? _asString(data?['payment_url']) ?? '';
    final orderRef =
        _asString(json['order_ref']) ?? _asString(data?['order_ref']);

    return PaymentInitiationModel(paymentUrl: paymentUrl, orderRef: orderRef);
  }
}

class PaymentStatusModel extends PaymentStatusEntity {
  @override
  final String? paymentStatus;
  @override
  final String? orderStatus;
  @override
  final bool paid;

  const PaymentStatusModel({
    required this.paid,
    this.paymentStatus,
    this.orderStatus,
  });

  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) {
    final data = _extractMap(json['data']);
    final paidValue = json['paid'] ?? data?['paid'];
    return PaymentStatusModel(
      paid: _asBool(paidValue),
      paymentStatus:
          _asString(json['payment_status']) ??
          _asString(data?['payment_status']),
      orderStatus:
          _asString(json['order_status']) ?? _asString(data?['order_status']),
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

String? _asString(Object? value) {
  final result = value?.toString();
  if (result == null || result.trim().isEmpty || result == 'null') {
    return null;
  }
  return result;
}

bool _asBool(Object? value) {
  if (value is bool) {
    return value;
  }
  final normalized = value?.toString().trim().toLowerCase();
  return normalized == '1' || normalized == 'true' || normalized == 'yes';
}
