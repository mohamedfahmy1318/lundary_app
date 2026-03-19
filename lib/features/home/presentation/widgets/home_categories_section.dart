import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/features/home/data/models/category_model.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/home_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/home_state.dart';
import 'package:laundry/features/home/presentation/widgets/category_chip.dart';
import 'package:laundry/features/home/presentation/widgets/section_header.dart';

class HomeCategoriesSection extends StatelessWidget {
  final int selectedCategoryIndex;
  final List<CategoryModel> categories;
  final ValueChanged<int> onCategoryTap;
  final ValueChanged<List<CategoryModel>> onCategoriesLoaded;
  final HomeCubit homeCubit;
  final CategoryServicesCubit servicesCubit;

  static const _defaultIcons = [
    Icons.local_laundry_service,
    Icons.iron,
    Icons.dry_cleaning,
    Icons.auto_awesome,
    Icons.cleaning_services,
    Icons.checkroom,
  ];

  const HomeCategoriesSection({
    super.key,
    required this.selectedCategoryIndex,
    required this.categories,
    required this.onCategoryTap,
    required this.onCategoriesLoaded,
    required this.homeCubit,
    required this.servicesCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: 'Categories', onViewAll: () {}),
        SizedBox(height: 12.h),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (cats) {
                onCategoriesLoaded(cats);
                if (cats.isNotEmpty) {
                  servicesCubit.getServices(
                    categoryId: cats[selectedCategoryIndex].id,
                  );
                }
              },
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => SizedBox(
                height: 48.h,
                child: const Center(child: CircularProgressIndicator()),
              ),
              loaded: (cats) => SizedBox(
                height: 48.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: cats.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10.w),
                  itemBuilder: (_, index) {
                    final cat = cats[index];
                    return CategoryChip(
                      label: cat.name,
                      icon: _defaultIcons[index % _defaultIcons.length],
                      isSelected: index == selectedCategoryIndex,
                      onTap: () => onCategoryTap(index),
                    );
                  },
                ),
              ),
              error: (message) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Text(
                      message,
                      style: TextStyle(color: Colors.red, fontSize: 13.sp),
                    ),
                    SizedBox(height: 8.h),
                    TextButton(
                      onPressed: () => homeCubit.getCategories(),
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
}
