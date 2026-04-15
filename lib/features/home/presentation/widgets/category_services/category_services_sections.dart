import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_cubit.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_state.dart';
import 'package:laundry/features/home/domain/entities/home_service_entity.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_state.dart';
import 'package:laundry/features/home/presentation/utils/service_basket_actions.dart';
import 'package:laundry/features/home/presentation/widgets/service_item_card.dart';

class CategoryServicesStateView extends StatelessWidget {
  final CategoryServicesState state;
  final BasketCubit basketCubit;
  final String selectedCategoryName;
  final VoidCallback onRetry;

  const CategoryServicesStateView({
    super.key,
    required this.state,
    required this.basketCubit,
    required this.selectedCategoryName,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return state.when(
      initial: () => const SizedBox.shrink(),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded:
          (services) => CategoryServicesGrid(
            services: services,
            basketCubit: basketCubit,
            selectedCategoryName: selectedCategoryName,
          ),
      error:
          (message) =>
              CategoryServicesErrorView(message: message, onRetry: onRetry),
    );
  }
}

class CategoryServicesGrid extends StatelessWidget {
  final List<HomeServiceEntity> services;
  final BasketCubit basketCubit;
  final String selectedCategoryName;

  const CategoryServicesGrid({
    super.key,
    required this.services,
    required this.basketCubit,
    required this.selectedCategoryName,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return Center(
        child: Text(
          'No services available',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
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
          builder: (context, _) {
            final quantity = basketCubit.getQuantity(service.id);
            return ServiceItemCard(
              name: service.name,
              price: service.priceAsDouble,
              imageUrl: service.image,
              quantity: quantity,
              onIncrement:
                  () => service.addToBasket(
                    basketCubit,
                    fallbackCategoryName: selectedCategoryName,
                  ),
              onDecrement: () => basketCubit.decrementItem(service.id),
            );
          },
        );
      },
    );
  }
}

class CategoryServicesErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CategoryServicesErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontSize: 13.sp),
          ),
          SizedBox(height: 12.h),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class CategoryBasketCheckoutBar extends StatelessWidget {
  final BasketCubit basketCubit;
  final VoidCallback onCheckout;

  const CategoryBasketCheckoutBar({
    super.key,
    required this.basketCubit,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketCubit, BasketState>(
      builder: (context, _) {
        final totalItems = basketCubit.totalItemsCount;
        if (totalItems == 0) {
          return const SizedBox.shrink();
        }

        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: onCheckout,
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
    );
  }
}
