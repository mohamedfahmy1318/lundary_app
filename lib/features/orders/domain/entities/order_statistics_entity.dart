abstract class OrderStatisticsEntity {
  const OrderStatisticsEntity();

  int get totalOrders;
  int get pendingOrders;
  int get completedOrders;
  int get totalSpent;
}
