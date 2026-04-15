import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/home/domain/entities/home_category_entity.dart';
import 'package:laundry/features/home/domain/repos/home_repo.dart';

class GetHomeCategoriesUseCase {
  final HomeRepo _homeRepo;

  const GetHomeCategoriesUseCase({required HomeRepo homeRepo})
    : _homeRepo = homeRepo;

  Future<Either<Failure, List<HomeCategoryEntity>>> call() {
    return _homeRepo.getCategories();
  }
}
