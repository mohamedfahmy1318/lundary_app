enum OrderStatus {
  pending,
  confirmed,
  pickingUp,
  pickedUp,
  processing,
  ready,
  outForDelivery,
  delivered,
  completed,
  cancelled,
}

extension OrderStatusX on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.pickingUp:
        return 'Picking Up';
      case OrderStatus.pickedUp:
        return 'Picked Up';
      case OrderStatus.processing:
        return 'In Process';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive {
    switch (this) {
      case OrderStatus.pending:
      case OrderStatus.confirmed:
      case OrderStatus.pickingUp:
      case OrderStatus.pickedUp:
      case OrderStatus.processing:
      case OrderStatus.ready:
      case OrderStatus.outForDelivery:
        return true;
      case OrderStatus.delivered:
      case OrderStatus.completed:
      case OrderStatus.cancelled:
        return false;
    }
  }
}
