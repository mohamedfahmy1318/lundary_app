import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:laundry/features/home/data/models/post_model.dart';
import 'package:laundry/features/home/domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  HomeRepoImpl({
    required HomeRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<PostModel>>> getPosts() async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final posts = await _remoteDataSource.getPosts();
      return Right(posts);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostModel>> getPostById(int id) async {
    if (!await _networkInfo.isConnected) {
      return const Left(NoInternetFailure());
    }
    try {
      final post = await _remoteDataSource.getPostById(id);
      return Right(post);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
