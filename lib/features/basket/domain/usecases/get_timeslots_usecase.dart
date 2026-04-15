import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/basket/domain/entities/time_slot_entity.dart';
import 'package:laundry/features/basket/domain/repos/basket_repo.dart';

class GetTimeslotsParams extends Equatable {
  final String date;

  const GetTimeslotsParams({required this.date});

  @override
  List<Object?> get props => [date];
}

class GetTimeslotsUseCase {
  final BasketRepo _basketRepo;

  const GetTimeslotsUseCase({required BasketRepo basketRepo})
    : _basketRepo = basketRepo;

  Future<Either<Failure, List<TimeSlotEntity>>> call(
    GetTimeslotsParams params,
  ) {
    return _basketRepo.getTimeslots(params.date);
  }
}
