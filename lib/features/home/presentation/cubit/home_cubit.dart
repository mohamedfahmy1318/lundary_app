import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/home/domain/entities/home_banner_entity.dart';
import 'package:laundry/features/home/domain/entities/home_category_entity.dart';

import 'package:laundry/features/home/domain/usecases/get_home_banners_usecase.dart';
import 'package:laundry/features/home/domain/usecases/get_home_categories_usecase.dart';
import 'package:laundry/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeCategoriesUseCase _getHomeCategoriesUseCase;
  final GetHomeBannersUseCase _getHomeBannersUseCase;

  HomeCubit({
    required GetHomeCategoriesUseCase getHomeCategoriesUseCase,
    required GetHomeBannersUseCase getHomeBannersUseCase,
  }) : _getHomeCategoriesUseCase = getHomeCategoriesUseCase,
       _getHomeBannersUseCase = getHomeBannersUseCase,
       super(const HomeState.initial());

  Future<void> loadHomeContent() async {
    emit(const HomeState.loading());

    final categoriesFuture = _getHomeCategoriesUseCase();
    final bannersFuture = _getHomeBannersUseCase();

    final categoriesResult = await categoriesFuture;
    final bannersResult = await bannersFuture;

    final categories = _categoriesOrNull(categoriesResult);
    if (categories == null) {
      return;
    }

    final banners = _bannersOrNull(bannersResult);
    if (banners == null) {
      return;
    }

    emit(HomeState.loaded(categories, banners));
  }

  Future<void> getCategories() {
    return loadHomeContent();
  }

  List<HomeCategoryEntity>? _categoriesOrNull(
    Either<Failure, List<HomeCategoryEntity>> result,
  ) {
    return result.fold((failure) {
      emit(HomeState.error(failure.message));
      return null;
    }, (categories) => categories);
  }

  List<HomeBannerEntity>? _bannersOrNull(
    Either<Failure, List<HomeBannerEntity>> result,
  ) {
    return result.fold((failure) {
      emit(HomeState.error(failure.message));
      return null;
    }, (banners) => banners);
  }
}
