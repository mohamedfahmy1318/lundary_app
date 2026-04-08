import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:laundry/features/home/domain/repos/home_repo.dart';
import 'package:laundry/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit({required HomeRepo homeRepo})
    : _homeRepo = homeRepo,
      super(const HomeState.initial());

  Future<void> getCategories() async {
    emit(const HomeState.loading());

    final results = await Future.wait([
      _homeRepo.getCategories(),
      _homeRepo.getBanners(),
    ]);

    final categoriesResult = results[0];
    final bannersResult = results[1];

    categoriesResult.fold(
      (failure) => emit(HomeState.error(failure.message)),
      (categoriesData) {
        bannersResult.fold(
          (failure) => emit(HomeState.error(failure.message)),
          (bannersData) {
            // categoriesData -> List<CategoryModel>
            // bannersData -> List<BannerModel>
            emit(HomeState.loaded(categoriesData as dynamic, bannersData as dynamic));
          },
        );
      },
    );
  }
}
