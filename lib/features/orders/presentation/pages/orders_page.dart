import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/chip_tab_bar.dart';
import '../../domain/entities/order_status.dart';
import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
import '../widgets/order_card.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final OrdersCubit _ordersCubit;
  final List<String> _tabs = ["All", "Pending", "Completed"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
    _ordersCubit = getIt<OrdersCubit>()..getOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _ordersCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _ordersCubit,
      child: Scaffold(
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
              child: BlocBuilder<OrdersCubit, OrdersState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    loaded: (orders) {
                      return TabBarView(
                        controller: _tabController,
                        children: [
                          _buildOrderList(null), // All
                          _buildOrderList(OrderStatus.pending),
                          _buildOrderList(OrderStatus.completed),
                        ],
                      );
                    },
                    error:
                        (message) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13.sp,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              TextButton(
                                onPressed: () => _ordersCubit.getOrders(),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(OrderStatus? filterStatus) {
    final orders = _ordersCubit.getFilteredOrders(filterStatus);

    if (orders.isEmpty) {
      return RefreshIndicator(
        onRefresh: () => _ordersCubit.getOrders(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverFillRemaining(child: Center(child: Text("No orders found"))),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _ordersCubit.getOrders(),
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderCard(
            order: orders[index],
            onTap: () {
              context.pushNamed('orderDetails', extra: orders[index]);
            },
          );
        },
      ),
    );
  }
}
