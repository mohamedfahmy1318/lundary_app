import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/home/domain/entities/home_banner_entity.dart';
import 'package:laundry/features/home/domain/entities/home_category_entity.dart';
import 'package:laundry/features/home/domain/entities/home_service_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<HomeCategoryEntity>>> getCategories();
  Future<Either<Failure, List<HomeServiceEntity>>> getServices({
    int? categoryId,
    String? search,
  });
  Future<Either<Failure, List<HomeServiceEntity>>> getTopServices({
    String period,
    int limit,
  });
  Future<Either<Failure, List<HomeBannerEntity>>> getBanners();
}
