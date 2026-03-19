import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_cubit.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_state.dart';
import 'package:laundry/features/home/data/models/category_model.dart';
import 'package:laundry/features/home/data/models/service_model.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_state.dart';
import 'package:laundry/features/home/presentation/widgets/quick_pick_card.dart';
import 'package:laundry/features/home/presentation/widgets/section_header.dart';

class HomeQuickPicksSection extends StatelessWidget {
  final List<CategoryModel> categories;
  final int selectedCategoryIndex;
  final BasketCubit basketCubit;
  final CategoryServicesCubit servicesCubit;

  const HomeQuickPicksSection({
    super.key,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.basketCubit,
    required this.servicesCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionHeader(title: 'Quick Picks', onViewAll: () {}),
        SizedBox(height: 12.h),
        BlocBuilder<CategoryServicesCubit, CategoryServicesState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: const Center(child: CircularProgressIndicator()),
              ),
              loaded: (services) => _QuickPicksGrid(
                services: services,
                basketCubit: basketCubit,
              ),
              error: (message) => Padding(
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
                        if (categories.isNotEmpty) {
                          servicesCubit.getServices(
                            categoryId: categories[selectedCategoryIndex].id,
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
}

class _QuickPicksGrid extends StatelessWidget {
  final List<ServiceModel> services;
  final BasketCubit basketCubit;

  const _QuickPicksGrid({
    required this.services,
    required this.basketCubit,
  });

  @override
  Widget build(BuildContext context) {
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
            builder: (context, _) {
              final qty = basketCubit.getQuantity(service.id);
              return QuickPickCard(
                name: service.name,
                category: service.category?.name ?? '',
                quantity: qty,
                onIncrement: () => basketCubit.addItem(
                  serviceId: service.id,
                  serviceName: service.name,
                  categoryName: service.category?.name ?? '',
                  unitPrice: service.priceAsDouble,
                ),
                onDecrement: () => basketCubit.decrementItem(service.id),
              );
            },
          );
        },
      ),
    );
  }
}
