import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/chip_tab_bar.dart';
import '../../data/models/order_model.dart';
import '../widgets/order_card.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ["Completed", "All", "In Progress"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBarFactory.build(context, title: "Orders", showBack: false),
      body: Column(
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ChipTabBar(
              tabs: _tabs,
              selectedIndex: _tabController.index,
              onTap: (i) {
                _tabController.animateTo(i);
                setState(() {});
              },
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOrderList(OrderStatus.completed),
                _buildOrderList(null), // All
                _buildOrderList(OrderStatus.inProgress),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList(OrderStatus? filterStatus) {
    List<OrderModel> orders = OrderModel.mockOrders;

    if (filterStatus != null) {
      orders = orders.where((o) => o.status == filterStatus).toList();
    }

    if (orders.isEmpty) {
      return const Center(child: Text("No orders found"));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        return OrderCard(
          order: orders[index],
          onTap: () {
            context.pushNamed('orderDetails', extra: orders[index]);
          },
        );
      },
    );
  }
}
