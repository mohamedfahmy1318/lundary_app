import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/chip_tab_bar.dart';
import '../../../basket/presentation/cubit/basket_cubit.dart';
import '../../../basket/presentation/cubit/basket_state.dart';
import '../../data/models/category_model.dart';
import '../cubit/category_services_cubit.dart';
import '../cubit/category_services_state.dart';
import '../widgets/service_item_card.dart';

/// Displays all categories as horizontal chips.
/// When a chip is selected, loads services for that category from the API.
class CategoryServicesPage extends StatefulWidget {
  final List<CategoryModel> categories;
  final int initialCategoryIndex;

  const CategoryServicesPage({
    super.key,
    required this.categories,
    this.initialCategoryIndex = 0,
  });

  @override
  State<CategoryServicesPage> createState() => _CategoryServicesPageState();
}

class _CategoryServicesPageState extends State<CategoryServicesPage> {
  late int _selectedIndex;
  late final CategoryServicesCubit _cubit;
  final BasketCubit _basketCubit = getIt<BasketCubit>();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialCategoryIndex;
    _cubit = getIt<CategoryServicesCubit>();
    _loadServices();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _loadServices() {
    final categoryId = widget.categories[_selectedIndex].id;
    _cubit.getServices(categoryId: categoryId);
  }

  void _onCategoryTap(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    _loadServices();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cubit),
        BlocProvider.value(value: _basketCubit),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBarFactory.build(
          context,
          title: widget.categories[_selectedIndex].name,
          onBack: () => context.pop(),
        ),
        body: Column(
          children: [
            SizedBox(height: 16.h),

            // ── Category chips ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ChipTabBar(
                tabs: widget.categories.map((c) => c.name).toList(),
                selectedIndex: _selectedIndex,
                onTap: _onCategoryTap,
                expanded: false,
              ),
            ),

            SizedBox(height: 20.h),

            // ── Services grid ──
            Expanded(
              child: BlocBuilder<CategoryServicesCubit, CategoryServicesState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading:
                        () => const Center(child: CircularProgressIndicator()),
                    loaded: (services) {
                      if (services.isEmpty) {
                        return Center(
                          child: Text(
                            'No services available',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                      return GridView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 8.h,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 14.h,
                          crossAxisSpacing: 14.w,
                          childAspectRatio: 0.78,
                        ),
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          final service = services[index];
                          return BlocBuilder<BasketCubit, BasketState>(
                            builder: (context, basketState) {
                              final qty = _basketCubit.getQuantity(service.id);
                              return ServiceItemCard(
                                name: service.name,
                                price: service.priceAsDouble,
                                quantity: qty,
                                onIncrement:
                                    () => _basketCubit.addItem(
                                      serviceId: service.id,
                                      serviceName: service.name,
                                      categoryName:
                                          widget
                                              .categories[_selectedIndex]
                                              .name,
                                      unitPrice: service.priceAsDouble,
                                    ),
                                onDecrement:
                                    () =>
                                        _basketCubit.decrementItem(service.id),
                              );
                            },
                          );
                        },
                      );
                    },
                    error:
                        (message) => Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 13.sp,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              TextButton(
                                onPressed: _loadServices,
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                  );
                },
              ),
            ),

            // ── Add to basket button ──
            BlocBuilder<BasketCubit, BasketState>(
              builder: (context, state) {
                final totalItems = _basketCubit.totalItemsCount;
                if (totalItems == 0) return const SizedBox.shrink();
                return SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: () => context.pushNamed('basket'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Add to Basket  ·  $totalItems items',
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
