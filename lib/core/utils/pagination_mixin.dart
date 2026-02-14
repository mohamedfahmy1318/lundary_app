import 'package:flutter_bloc/flutter_bloc.dart';

/// Mixin for any Cubit that needs pagination.
///
/// Usage:
/// ```dart
///   class ProductsCubit extends Cubit<ProductsState> with PaginationMixin {
///     Future<void> getProducts() async {
///       if (isLoading || !hasMore) return;
///       isLoading = true;
///
///       final result = await repo.getProducts(page: currentPage);
///       result.fold(
///         (failure) { isLoading = false; },
///         (newItems) {
///           allItems.addAll(newItems);
///           onPageLoaded(); // increments page + checks hasMore
///           emit(ProductsState.loaded(List.from(allItems)));
///         },
///       );
///     }
///
///     void refresh() {
///       resetPagination();
///       allItems.clear();
///       getProducts();
///     }
///   }
/// ```
mixin PaginationMixin<T> on BlocBase {
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoading = false;
  final List<T> allItems = [];

  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  set isLoading(bool value) => _isLoading = value;

  void onPageLoaded({int? lastPage, bool? hasMoreItems}) {
    _isLoading = false;
    if (hasMoreItems != null) {
      _hasMore = hasMoreItems;
    } else if (lastPage != null) {
      _hasMore = _currentPage < lastPage;
    }
    _currentPage++;
  }

  void resetPagination() {
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;
    allItems.clear();
  }
}
