class PaymentCardModel {
  final String id;
  final String brand; // 'Visa', 'Mastercard', etc.
  final String lastFour;
  final String cardholderName;
  final String expiryDate; // MM/YYYY
  final bool isDefault;

  PaymentCardModel({
    required this.id,
    required this.brand,
    required this.lastFour,
    required this.cardholderName,
    required this.expiryDate,
    this.isDefault = false,
  });

  factory PaymentCardModel.fromJson(Map<String, dynamic> json) {
    return PaymentCardModel(
      id: json['id']?.toString() ?? '',
      brand: json['brand'] as String? ?? '',
      lastFour: json['last_four'] as String? ?? '',
      cardholderName: json['cardholder_name'] as String? ?? '',
      expiryDate: json['expiry_date'] as String? ?? '',
      isDefault: json['is_default'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'last_four': lastFour,
      'cardholder_name': cardholderName,
      'expiry_date': expiryDate,
      'is_default': isDefault,
    };
  }

  static List<PaymentCardModel> get mockCards => [
    PaymentCardModel(
      id: 'card_1',
      brand: 'Visa',
      lastFour: '4242',
      cardholderName: 'JOHN DOE',
      expiryDate: '12/2028',
      isDefault: true,
    ),
    PaymentCardModel(
      id: 'card_2',
      brand: 'Mastercard',
      lastFour: '8888',
      cardholderName: 'JOHN DOE',
      expiryDate: '06/2027',
    ),
  ];
}
