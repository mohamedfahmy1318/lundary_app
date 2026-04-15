import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/features/home/presentation/cubit/home_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/home_state.dart';
import 'package:laundry/features/home/presentation/widgets/category_chip.dart';
import 'package:laundry/features/home/presentation/widgets/section_header.dart';

class HomeCategoriesSection extends StatelessWidget {
  final int selectedCategoryIndex;
  final ValueChanged<int> onCategoryTap;
  final HomeCubit homeCubit;

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
    required this.onCategoryTap,
    required this.homeCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: 'Categories', onViewAll: () {}),
        SizedBox(height: 12.h),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading:
                  () => SizedBox(
                    height: 48.h,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              loaded: (categories, _) {
                if (categories.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'No categories available right now.',
                      style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                    ),
                  );
                }

                return SizedBox(
                  height: 48.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => SizedBox(width: 10.w),
                    itemBuilder: (_, index) {
                      final category = categories[index];
                      return CategoryChip(
                        label: category.name,
                        icon: _defaultIcons[index % _defaultIcons.length],
                        imageUrl: category.image,
                        isSelected: index == selectedCategoryIndex,
                        onTap: () => onCategoryTap(index),
                      );
                    },
                  ),
                );
              },
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
                          onPressed: () => homeCubit.loadHomeContent(),
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
