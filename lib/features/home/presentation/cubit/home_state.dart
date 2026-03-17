import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:laundry/features/home/data/models/category_model.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded(List<CategoryModel> categories) = _Loaded;
  const factory HomeState.error(String message) = _Error;
}
