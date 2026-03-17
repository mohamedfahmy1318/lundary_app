import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:laundry/features/home/domain/repos/home_repo.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_state.dart';

class CategoryServicesCubit extends Cubit<CategoryServicesState> {
  final HomeRepo _homeRepo;

  CategoryServicesCubit({required HomeRepo homeRepo})
    : _homeRepo = homeRepo,
      super(const CategoryServicesState.initial());

  Future<void> getServices({int? categoryId}) async {
    emit(const CategoryServicesState.loading());

    final result = await _homeRepo.getServices(categoryId: categoryId);

    result.fold(
      (failure) => emit(CategoryServicesState.error(failure.message)),
      (services) => emit(CategoryServicesState.loaded(services)),
    );
  }
}
