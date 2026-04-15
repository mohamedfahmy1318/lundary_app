import 'package:dartz/dartz.dart';

import 'package:laundry/core/error/exceptions.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/features/home/data/data_sources/home_local_data_source.dart';
import 'package:laundry/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:laundry/features/home/data/models/category_model.dart';
import 'package:laundry/features/home/data/models/service_model.dart';
import 'package:laundry/features/home/data/models/banner_model.dart';
import 'package:laundry/features/home/domain/entities/home_banner_entity.dart';
import 'package:laundry/features/home/domain/entities/home_category_entity.dart';
import 'package:laundry/features/home/domain/entities/home_service_entity.dart';
import 'package:laundry/features/home/domain/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  HomeRepoImpl({
    required HomeRemoteDataSource remoteDataSource,
    required HomeLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<HomeCategoryEntity>>> getCategories() {
    return _fetchWithCache<CategoryModel, HomeCategoryEntity>(
      fetchRemote: _remoteDataSource.getCategories,
      getCached: _localDataSource.getCachedCategories,
      cacheData: _localDataSource.cacheCategories,
    );
  }

  @override
  Future<Either<Failure, List<HomeServiceEntity>>> getServices({
    int? categoryId,
    String? search,
  }) {
    return _fetchWithCache<ServiceModel, HomeServiceEntity>(
      fetchRemote:
          () => _remoteDataSource.getServices(
            categoryId: categoryId,
            search: search,
          ),
      getCached:
          () => _localDataSource.getCachedServices(
            categoryId: categoryId,
            search: search,
          ),
      cacheData:
          (services) => _localDataSource.cacheServices(
            services,
            categoryId: categoryId,
            search: search,
          ),
    );
  }

  @override
  Future<Either<Failure, List<HomeServiceEntity>>> getTopServices({
    String period = 'all',
    int limit = 10,
  }) {
    return _fetchWithCache<ServiceModel, HomeServiceEntity>(
      fetchRemote:
          () => _remoteDataSource.getTopServices(period: period, limit: limit),
      getCached:
          () => _localDataSource.getCachedTopServices(
            period: period,
            limit: limit,
          ),
      cacheData:
          (services) => _localDataSource.cacheTopServices(
            services,
            period: period,
            limit: limit,
          ),
    );
  }

  @override
  Future<Either<Failure, List<HomeBannerEntity>>> getBanners() {
    return _fetchWithCache<BannerModel, HomeBannerEntity>(
      fetchRemote: _remoteDataSource.getBanners,
      getCached: _localDataSource.getCachedBanners,
      cacheData: _localDataSource.cacheBanners,
    );
  }

  Future<Either<Failure, List<TEntity>>>
  _fetchWithCache<TModel extends TEntity, TEntity>({
    required Future<List<TModel>> Function() fetchRemote,
    required Future<List<TModel>> Function() getCached,
    required Future<void> Function(List<TModel> data) cacheData,
  }) async {
    final isConnected = await _networkInfo.isConnected;

    if (isConnected) {
      try {
        final remoteData = await fetchRemote();
        await cacheData(remoteData);
        return Right(remoteData);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.message, statusCode: e.statusCode),
        );
      } on UnauthorizedException catch (e) {
        return Left(UnauthorizedFailure(message: e.message));
      } catch (e) {
        final fallback = await _tryGetCache(getCached);
        if (fallback != null) {
          return Right(fallback);
        }
        return Left(UnknownFailure(message: e.toString()));
      }
    }

    final cachedData = await _tryGetCache(getCached);
    if (cachedData != null) {
      return Right(cachedData);
    }

    return const Left(NoInternetFailure());
  }

  Future<List<TEntity>?> _tryGetCache<TModel extends TEntity, TEntity>(
    Future<List<TModel>> Function() getCached,
  ) async {
    try {
      final cachedData = await getCached();
      return cachedData;
    } on CacheException {
      return null;
    } catch (_) {
      return null;
    }
  }
}
