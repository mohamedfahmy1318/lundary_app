import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/home/data/models/category_model.dart';
import 'package:laundry/features/home/data/models/service_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, List<ServiceModel>>> getServices({
    int? categoryId,
    String? search,
  });
}
