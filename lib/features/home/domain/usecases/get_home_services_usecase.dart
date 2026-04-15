import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/home/domain/entities/home_service_entity.dart';
import 'package:laundry/features/home/domain/repos/home_repo.dart';

class GetHomeServicesParams extends Equatable {
  final int? categoryId;
  final String? search;

  const GetHomeServicesParams({this.categoryId, this.search});

  @override
  List<Object?> get props => [categoryId, search];
}

class GetHomeServicesUseCase {
  final HomeRepo _homeRepo;

  const GetHomeServicesUseCase({required HomeRepo homeRepo})
    : _homeRepo = homeRepo;

  Future<Either<Failure, List<HomeServiceEntity>>> call(
    GetHomeServicesParams params,
  ) {
    return _homeRepo.getServices(
      categoryId: params.categoryId,
      search: params.search,
    );
  }
}
