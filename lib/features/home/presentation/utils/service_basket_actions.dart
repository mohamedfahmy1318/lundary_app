import 'package:laundry/features/basket/presentation/cubit/basket_cubit.dart';
import 'package:laundry/features/home/domain/entities/home_service_entity.dart';

extension ServiceBasketActions on HomeServiceEntity {
  String categoryName({String fallbackCategoryName = ''}) {
    return category?.name ?? fallbackCategoryName;
  }

  void addToBasket(
    BasketCubit basketCubit, {
    String fallbackCategoryName = '',
  }) {
    basketCubit.addItem(
      serviceId: id,
      serviceName: name,
      categoryName: categoryName(fallbackCategoryName: fallbackCategoryName),
      unitPrice: priceAsDouble,
    );
  }
}
