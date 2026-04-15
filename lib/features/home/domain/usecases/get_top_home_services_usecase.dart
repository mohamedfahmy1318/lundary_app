import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/home/domain/entities/home_service_entity.dart';
import 'package:laundry/features/home/domain/repos/home_repo.dart';

class GetTopHomeServicesParams extends Equatable {
  final String period;
  final int limit;

  const GetTopHomeServicesParams({this.period = 'all', this.limit = 10});

  @override
  List<Object?> get props => [period, limit];
}

class GetTopHomeServicesUseCase {
  final HomeRepo _homeRepo;

  const GetTopHomeServicesUseCase({required HomeRepo homeRepo})
    : _homeRepo = homeRepo;

  Future<Either<Failure, List<HomeServiceEntity>>> call(
    GetTopHomeServicesParams params,
  ) {
    return _homeRepo.getTopServices(period: params.period, limit: params.limit);
  }
}
