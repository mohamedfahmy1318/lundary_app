import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/chip_tab_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/sticky_bottom_bar.dart';
import '../../data/models/basket_item_model.dart';
import '../widgets/basket_item_card.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ["Washing", "Dry Cleaning", "Ironing"];
  late List<BasketItemModel> _items;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
    _items = BasketItemModel.mockItems;
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
      appBar: AppBarFactory.build(
        context,
        title: "Laundry Basket",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 16.h),
          // Tabs
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ChipTabBar(
              tabs: _tabs,
              selectedIndex: _tabController.index,
              onTap: (i) => _tabController.animateTo(i),
              expanded: false,
            ),
          ),
          SizedBox(height: 24.h),

          // Tab View Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _tabs.map((tabName) {
                final categoryItems = _items
                    .where((item) => item.category == tabName)
                    .toList();
                return GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 8.h,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: categoryItems.length,
                  itemBuilder: (context, index) {
                    final item = categoryItems[index];
                    return BasketItemCard(
                      item: item,
                      onIncrement: () => setState(() => item.quantity++),
                      onDecrement: () {
                        setState(() {
                          if (item.quantity > 0) item.quantity--;
                        });
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ),

          // Sticky Bottom Button
          StickyBottomBar(
            child: CustomButton(
              text: "Complete Process",
              onPressed: () => context.pushNamed('pickupSchedule'),
            ),
          ),
        ],
      ),
    );
  }
}
