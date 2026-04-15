import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/basket/domain/entities/order_request_entity.dart';
import 'package:laundry/features/basket/domain/entities/order_response_entity.dart';
import 'package:laundry/features/basket/domain/entities/time_slot_entity.dart';

abstract class BasketRepo {
  Future<Either<Failure, OrderResponseEntity>> createOrder(
    CreateOrderRequestEntity orderData,
  );
  Future<Either<Failure, List<TimeSlotEntity>>> getTimeslots(String date);
}
