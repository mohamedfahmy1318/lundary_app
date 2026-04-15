import 'package:dartz/dartz.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/home/domain/entities/home_banner_entity.dart';
import 'package:laundry/features/home/domain/repos/home_repo.dart';

class GetHomeBannersUseCase {
  final HomeRepo _homeRepo;

  const GetHomeBannersUseCase({required HomeRepo homeRepo})
    : _homeRepo = homeRepo;

  Future<Either<Failure, List<HomeBannerEntity>>> call() {
    return _homeRepo.getBanners();
  }
}
