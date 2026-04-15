import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/core/error/failures.dart';
import 'package:laundry/features/home/domain/entities/home_service_entity.dart';
import 'package:laundry/features/home/domain/usecases/get_home_services_usecase.dart';
import 'package:laundry/features/home/domain/usecases/get_top_home_services_usecase.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_state.dart';

class CategoryServicesCubit extends Cubit<CategoryServicesState> {
  final GetHomeServicesUseCase _getHomeServicesUseCase;
  final GetTopHomeServicesUseCase _getTopHomeServicesUseCase;

  CategoryServicesCubit({
    required GetHomeServicesUseCase getHomeServicesUseCase,
    required GetTopHomeServicesUseCase getTopHomeServicesUseCase,
  }) : _getHomeServicesUseCase = getHomeServicesUseCase,
       _getTopHomeServicesUseCase = getTopHomeServicesUseCase,
       super(const CategoryServicesState.initial());

  Future<void> loadServices({int? categoryId}) {
    return _loadServices(
      () => _getHomeServicesUseCase(
        GetHomeServicesParams(categoryId: categoryId),
      ),
    );
  }

  Future<void> loadTopServices({String period = 'all', int limit = 10}) {
    return _loadServices(
      () => _getTopHomeServicesUseCase(
        GetTopHomeServicesParams(period: period, limit: limit),
      ),
    );
  }

  Future<void> getServices({int? categoryId}) async {
    return loadServices(categoryId: categoryId);
  }

  Future<void> getTopServices({String period = 'all', int limit = 10}) async {
    return loadTopServices(period: period, limit: limit);
  }

  Future<void> _loadServices(
    Future<Either<Failure, List<HomeServiceEntity>>> Function() request,
  ) async {
    emit(const CategoryServicesState.loading());

    final result = await request();

    result.fold(
      (failure) => emit(CategoryServicesState.error(failure.message)),
      (services) => emit(CategoryServicesState.loaded(services)),
    );
  }
}
