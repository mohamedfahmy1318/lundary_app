import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';

abstract class BasketRepo {
  Future<Either<Failure, Map<String, dynamic>>> createOrder(
    Map<String, dynamic> orderData,
  );
}
