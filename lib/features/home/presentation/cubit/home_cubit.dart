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

    final result = await _homeRepo.getCategories();

    result.fold(
      (failure) => emit(HomeState.error(failure.message)),
      (categories) => emit(HomeState.loaded(categories)),
    );
  }
}
