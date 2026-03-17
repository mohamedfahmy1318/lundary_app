import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:laundry/features/home/data/models/service_model.dart';

part 'category_services_state.freezed.dart';

@freezed
abstract class CategoryServicesState with _$CategoryServicesState {
  const factory CategoryServicesState.initial() = _Initial;
  const factory CategoryServicesState.loading() = _Loading;
  const factory CategoryServicesState.loaded(List<ServiceModel> services) =
      _Loaded;
  const factory CategoryServicesState.error(String message) = _Error;
}
