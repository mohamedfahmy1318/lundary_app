import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/basket/data/models/basket_item_model.dart';

abstract class BasketRepo {
  Future<Either<Failure, List<BasketItemModel>>> getServices();
  Future<Either<Failure, Map<String, dynamic>>> createOrder(
    Map<String, dynamic> orderData,
  );
}
