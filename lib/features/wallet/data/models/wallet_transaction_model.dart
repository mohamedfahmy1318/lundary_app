enum TransactionType { topUp, payment, refund }

class WalletTransactionModel {
  final String id;
  final String title;
  final String description;
  final double amount;
  final TransactionType type;
  final DateTime date;

  WalletTransactionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.type,
    required this.date,
  });

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      type: _parseType(json['type'] as String?),
      date: json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'amount': amount,
      'type': type.name,
      'date': date.toIso8601String(),
    };
  }

  static TransactionType _parseType(String? type) {
    switch (type) {
      case 'top_up':
        return TransactionType.topUp;
      case 'payment':
        return TransactionType.payment;
      case 'refund':
        return TransactionType.refund;
      default:
        return TransactionType.payment;
    }
  }

  bool get isCredit =>
      type == TransactionType.topUp || type == TransactionType.refund;

  static List<WalletTransactionModel> get mockTransactions => [
    WalletTransactionModel(
      id: 'TXN001',
      title: 'Wallet Top-up',
      description: 'Card payment',
      amount: 200.0,
      type: TransactionType.topUp,
      date: DateTime(2026, 2, 13, 14, 30),
    ),
    WalletTransactionModel(
      id: 'TXN002',
      title: 'Order #22456',
      description: 'Laundry service',
      amount: 80.0,
      type: TransactionType.payment,
      date: DateTime(2026, 2, 12, 10, 15),
    ),
    WalletTransactionModel(
      id: 'TXN003',
      title: 'Wallet Top-up',
      description: 'Apple Pay',
      amount: 100.0,
      type: TransactionType.topUp,
      date: DateTime(2026, 2, 10, 9, 0),
    ),
    WalletTransactionModel(
      id: 'TXN004',
      title: 'Order #22455',
      description: 'Dry cleaning',
      amount: 150.0,
      type: TransactionType.payment,
      date: DateTime(2026, 2, 8, 16, 45),
    ),
    WalletTransactionModel(
      id: 'TXN005',
      title: 'Refund - Order #22450',
      description: 'Service cancelled',
      amount: 45.0,
      type: TransactionType.refund,
      date: DateTime(2026, 2, 5, 11, 20),
    ),
    WalletTransactionModel(
      id: 'TXN006',
      title: 'Order #22449',
      description: 'Ironing service',
      amount: 30.0,
      type: TransactionType.payment,
      date: DateTime(2026, 2, 3, 13, 10),
    ),
  ];
}
