import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/widgets/app_bar_factory.dart';
import '../../../../core/widgets/chip_tab_bar.dart';
import '../../../basket/presentation/cubit/basket_cubit.dart';
import '../../domain/entities/home_category_entity.dart';
import '../cubit/category_services_cubit.dart';
import '../cubit/category_services_state.dart';
import '../widgets/category_services/category_services_sections.dart';

/// Displays all categories as horizontal chips.
/// When a chip is selected, loads services for that category from the API.
class CategoryServicesPage extends StatefulWidget {
  final List<HomeCategoryEntity> categories;
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

  bool get _hasCategories => widget.categories.isNotEmpty;

  String get _selectedCategoryName {
    if (!_hasCategories) {
      return 'Services';
    }
    return widget.categories[_selectedIndex].name;
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = _normalizedCategoryIndex(widget.initialCategoryIndex);
    _cubit = getIt<CategoryServicesCubit>();
    _loadServices();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _loadServices() {
    if (!_hasCategories) {
      return;
    }

    final categoryId = widget.categories[_selectedIndex].id;
    _cubit.loadServices(categoryId: categoryId);
  }

  void _onCategoryTap(int index) {
    if (index == _selectedIndex) {
      return;
    }

    setState(() => _selectedIndex = index);
    _loadServices();
  }

  int _normalizedCategoryIndex(int index) {
    if (widget.categories.isEmpty) {
      return 0;
    }
    if (index < 0) {
      return 0;
    }
    if (index >= widget.categories.length) {
      return widget.categories.length - 1;
    }
    return index;
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
          title: _selectedCategoryName,
          onBack: () => context.pop(),
        ),
        body: Column(
          children: [
            SizedBox(height: 16.h),

            // ── Category chips ──
            if (_hasCategories)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ChipTabBar(
                  tabs:
                      widget.categories
                          .map((category) => category.name)
                          .toList(),
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
                  if (!_hasCategories) {
                    return Center(
                      child: Text(
                        'No categories available right now.',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                    );
                  }

                  return CategoryServicesStateView(
                    state: state,
                    basketCubit: _basketCubit,
                    selectedCategoryName: _selectedCategoryName,
                    onRetry: _loadServices,
                  );
                },
              ),
            ),

            // ── Add to basket button ──
            CategoryBasketCheckoutBar(
              basketCubit: _basketCubit,
              onCheckout: () => context.pushNamed('basket'),
            ),
          ],
        ),
      ),
    );
  }
}
