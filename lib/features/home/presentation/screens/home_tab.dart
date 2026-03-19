import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_cubit.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_state.dart';
import 'package:laundry/features/home/data/models/category_model.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/home_cubit.dart';
import 'package:laundry/features/home/presentation/widgets/home_app_bar.dart';
import 'package:laundry/features/home/presentation/widgets/home_categories_section.dart';
import 'package:laundry/features/home/presentation/widgets/home_quick_picks_section.dart';
import 'package:laundry/features/home/presentation/widgets/promo_banner.dart';
import 'package:laundry/features/home/presentation/widgets/promo_dots_indicator.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final HomeCubit _homeCubit;
  late final CategoryServicesCubit _servicesCubit;
  final BasketCubit _basketCubit = getIt<BasketCubit>();

  final List<CategoryModel> _categories = [];
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
                  builder:
                      (context, _) => HomeAppBar(
                        location: 'Mirdif, Dubai',
                        cartCount: _basketCubit.totalItemsCount,
                        onCartTap: () => context.pushNamed('basket'),
                      ),
                ),
                SizedBox(height: 16.h),
                const PromoBanner(title: 'Welcome Offers', discount: '50%'),
                SizedBox(height: 12.h),
                const PromodotsIndicator(),
                SizedBox(height: 24.h),
                HomeCategoriesSection(
                  selectedCategoryIndex: _selectedCategoryIndex,
                  categories: _categories,
                  onCategoryTap: _onCategoryTap,
                  onCategoriesLoaded: (cats) => setState(() {
                    _categories
                      ..clear()
                      ..addAll(cats);
                  }),
                  homeCubit: _homeCubit,
                  servicesCubit: _servicesCubit,
                ),
                SizedBox(height: 24.h),
                HomeQuickPicksSection(
                  categories: _categories,
                  selectedCategoryIndex: _selectedCategoryIndex,
                  basketCubit: _basketCubit,
                  servicesCubit: _servicesCubit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
