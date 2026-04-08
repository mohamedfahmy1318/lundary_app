import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/basket/data/models/time_slot_model.dart';

abstract class BasketRepo {
  Future<Either<Failure, Map<String, dynamic>>> createOrder(
    Map<String, dynamic> orderData,
  );
  Future<Either<Failure, List<TimeSlotModel>>> getTimeslots(String date);
}
