import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/chip_tab_bar.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/sticky_bottom_bar.dart';
import '../../data/models/cart_item.dart';
import '../cubit/basket_cubit.dart';
import '../cubit/basket_state.dart';
import '../widgets/basket_item_card.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final basketCubit = getIt<BasketCubit>();

    return BlocProvider.value(
      value: basketCubit,
      child: Scaffold(
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
        body: BlocBuilder<BasketCubit, BasketState>(
          builder: (context, state) {
            final items = basketCubit.cartItems;
            if (items.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_basket_outlined,
                      size: 64.sp,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Your basket is empty',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            // Group items by category
            final categories = <String>{};
            for (final item in items) {
              categories.add(item.categoryName);
            }
            final categoryList = categories.toList();

            return _BasketContent(
              basketCubit: basketCubit,
              items: items,
              categories: categoryList,
            );
          },
        ),
      ),
    );
  }
}

class _BasketContent extends StatefulWidget {
  final BasketCubit basketCubit;
  final List<CartItem> items;
  final List<String> categories;

  const _BasketContent({
    required this.basketCubit,
    required this.items,
    required this.categories,
  });

  @override
  State<_BasketContent> createState() => _BasketContentState();
}

class _BasketContentState extends State<_BasketContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.categories.length,
      vsync: this,
    );
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(covariant _BasketContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categories.length != widget.categories.length) {
      _tabController.dispose();
      _tabController = TabController(
        length: widget.categories.length,
        vsync: this,
      );
      _tabController.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ChipTabBar(
            tabs: widget.categories,
            selectedIndex: _tabController.index,
            onTap: (i) => _tabController.animateTo(i),
            expanded: false,
          ),
        ),
        SizedBox(height: 24.h),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children:
                widget.categories.map((category) {
                  final categoryItems = widget.basketCubit.getItemsByCategory(
                    category,
                  );
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
                        onIncrement:
                            () => widget.basketCubit.addItem(
                              serviceId: item.serviceId,
                              serviceName: item.serviceName,
                              categoryName: item.categoryName,
                              unitPrice: item.unitPrice,
                            ),
                        onDecrement:
                            () => widget.basketCubit.decrementItem(
                              item.serviceId,
                            ),
                      );
                    },
                  );
                }).toList(),
          ),
        ),
        StickyBottomBar(
          child: CustomButton(
            text: "Complete Process",
            onPressed: () => context.pushNamed('pickupSchedule'),
          ),
        ),
      ],
    );
  }
}
