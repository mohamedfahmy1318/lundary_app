import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_cubit.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_state.dart';
import 'package:laundry/features/home/data/models/category_model.dart';
import 'package:laundry/features/home/data/models/service_model.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_state.dart';
import 'package:laundry/features/home/presentation/cubit/home_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/home_state.dart';
import 'package:laundry/features/home/presentation/widgets/category_chip.dart';
import 'package:laundry/features/home/presentation/widgets/home_app_bar.dart';
import 'package:laundry/features/home/presentation/widgets/promo_banner.dart';
import 'package:laundry/features/home/presentation/widgets/quick_pick_card.dart';
import 'package:laundry/features/home/presentation/widgets/section_header.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final HomeCubit _homeCubit;
  late final CategoryServicesCubit _servicesCubit;
  final BasketCubit _basketCubit = getIt<BasketCubit>();

  List<CategoryModel> _categories = [];
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>()..getCategories();
    _servicesCubit = getIt<CategoryServicesCubit>();
  }

  @override
  void dispose() {
    _homeCubit.close();
    _servicesCubit.close();
    super.dispose();
  }

  void _onCategoryTap(int index) {
    setState(() => _selectedCategoryIndex = index);
    _servicesCubit.getServices(categoryId: _categories[index].id);
    context.pushNamed(
      'categoryServices',
      extra: {'categories': _categories, 'selectedIndex': index},
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _homeCubit),
        BlocProvider.value(value: _servicesCubit),
        BlocProvider.value(value: _basketCubit),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 110.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<BasketCubit, BasketState>(
                  builder: (context, state) {
                    return HomeAppBar(
                      location: 'Mirdif, Dubai',
                      cartCount: _basketCubit.totalItemsCount,
                      onCartTap: () => context.pushNamed('basket'),
                    );
                  },
                ),
                SizedBox(height: 16.h),
                const PromoBanner(title: 'Welcome Offers', discount: '50%'),
                SizedBox(height: 12.h),
                _buildDots(),
                SizedBox(height: 24.h),
                _buildCategories(),
                SizedBox(height: 24.h),
                _buildQuickPicks(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final isActive = i == 2;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          width: isActive ? 10.w : 8.w,
          height: isActive ? 10.h : 8.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.blue : Colors.grey[400],
          ),
        );
      }),
    );
  }

  static const _defaultIcons = [
    Icons.local_laundry_service,
    Icons.iron,
    Icons.dry_cleaning,
    Icons.auto_awesome,
    Icons.cleaning_services,
    Icons.checkroom,
  ];

  Widget _buildCategories() {
    return Column(
      children: [
        SectionHeader(title: 'Categories', onViewAll: () {}),
        SizedBox(height: 12.h),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (categories) {
                _categories = categories;
                if (categories.isNotEmpty) {
                  _servicesCubit.getServices(
                    categoryId: categories[_selectedCategoryIndex].id,
                  );
                }
              },
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading:
                  () => SizedBox(
                    height: 48.h,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              loaded:
                  (categories) => SizedBox(
                    height: 48.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => SizedBox(width: 10.w),
                      itemBuilder: (_, index) {
                        final cat = categories[index];
                        return CategoryChip(
                          label: cat.name,
                          icon: _defaultIcons[index % _defaultIcons.length],
                          isSelected: index == _selectedCategoryIndex,
                          onTap: () => _onCategoryTap(index),
                        );
                      },
                    ),
                  ),
              error:
                  (message) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        Text(
                          message,
                          style: TextStyle(color: Colors.red, fontSize: 13.sp),
                        ),
                        SizedBox(height: 8.h),
                        TextButton(
                          onPressed: () => _homeCubit.getCategories(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickPicks() {
    return Column(
      children: [
        SectionHeader(title: 'Quick Picks', onViewAll: () {}),
        SizedBox(height: 12.h),
        BlocBuilder<CategoryServicesCubit, CategoryServicesState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading:
                  () => Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              loaded: (services) => _quickPicksGrid(services),
              error:
                  (message) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      children: [
                        Text(
                          message,
                          style: TextStyle(color: Colors.red, fontSize: 13.sp),
                        ),
                        SizedBox(height: 8.h),
                        TextButton(
                          onPressed: () {
                            if (_categories.isNotEmpty) {
                              _servicesCubit.getServices(
                                categoryId:
                                    _categories[_selectedCategoryIndex].id,
                              );
                            }
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
            );
          },
        ),
      ],
    );
  }

  Widget _quickPicksGrid(List<ServiceModel> services) {
    if (services.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Center(
          child: Text(
            'No services available',
            style: TextStyle(fontSize: 13.sp, color: Colors.grey),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 0.70,
        ),
        itemCount: services.length,
        itemBuilder: (_, index) {
          final service = services[index];
          return BlocBuilder<BasketCubit, BasketState>(
            builder: (context, basketState) {
              final qty = _basketCubit.getQuantity(service.id);
              return QuickPickCard(
                name: service.name,
                category: service.category?.name ?? '',
                quantity: qty,
                onIncrement:
                    () => _basketCubit.addItem(
                      serviceId: service.id,
                      serviceName: service.name,
                      categoryName: service.category?.name ?? '',
                      unitPrice: service.priceAsDouble,
                    ),
                onDecrement: () => _basketCubit.decrementItem(service.id),
              );
            },
          );
        },
      ),
    );
  }
}
