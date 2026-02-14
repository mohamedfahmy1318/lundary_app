import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/home/data/models/post_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<PostModel>>> getPosts();
  Future<Either<Failure, PostModel>> getPostById(int id);
}
