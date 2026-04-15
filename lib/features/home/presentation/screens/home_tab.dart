import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/core/services/local_storage_service.dart';
import 'package:laundry/core/utils/current_location_helper.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_cubit.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_state.dart';
import 'package:laundry/features/home/domain/entities/home_category_entity.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/home_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/home_state.dart';
import 'package:laundry/features/home/presentation/widgets/home_app_bar.dart';
import 'package:laundry/features/home/presentation/widgets/home_categories_section.dart';
import 'package:laundry/features/home/presentation/widgets/home_quick_picks_section.dart';
import 'package:laundry/features/home/presentation/widgets/home_banners_section.dart';
import 'package:laundry/features/select_address/presentation/screens/map_address_picker_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final HomeCubit _homeCubit;
  late final CategoryServicesCubit _quickPicksCubit;
  final BasketCubit _basketCubit = getIt<BasketCubit>();
  final LocalStorageService _localStorage = getIt<LocalStorageService>();

  int _selectedCategoryIndex = 0;
  String _currentLocation = 'Detecting location...';
  bool _isResolvingLocation = false;

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>()..loadHomeContent();
    _quickPicksCubit = getIt<CategoryServicesCubit>()..loadTopServices();
    _initializeLocation();
  }

  @override
  void dispose() {
    _homeCubit.close();
    _quickPicksCubit.close();
    super.dispose();
  }

  void _onCategoryTap(int index) {
    final categories = _availableCategories;
    if (categories.isEmpty || index >= categories.length) {
      return;
    }

    setState(() => _selectedCategoryIndex = index);
    context.pushNamed(
      'categoryServices',
      extra: {'categories': categories, 'selectedIndex': index},
    );
  }

  Future<void> _initializeLocation() async {
    final cached = _localStorage.getCurrentLocation();
    if (cached != null && cached.trim().isNotEmpty && mounted) {
      setState(() {
        _currentLocation = cached.trim();
      });
    }

    if (mounted) {
      setState(() {
        _isResolvingLocation = true;
      });
    }

    final detected = await CurrentLocationHelper.getCurrentAddress();
    if (!mounted) {
      return;
    }

    if (detected != null && detected.trim().isNotEmpty) {
      await _persistLocation(detected.trim(), updateState: true);
    } else if (cached == null || cached.trim().isEmpty) {
      setState(() {
        _currentLocation = 'Location unavailable';
      });
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _isResolvingLocation = false;
    });
  }

  Future<void> _persistLocation(
    String location, {
    required bool updateState,
  }) async {
    await _localStorage.saveCurrentLocation(location);

    final saved = _localStorage.getSavedLocations();
    final normalized =
        saved
            .where(
              (item) => item.trim().toLowerCase() != location.toLowerCase(),
            )
            .toList();
    final nextLocations = <String>[location, ...normalized];
    await _localStorage.saveSavedLocations(nextLocations);

    if (updateState && mounted) {
      setState(() {
        _currentLocation = location;
      });
    }
  }

  Future<void> _onLocationTap() async {
    final selectedAddress = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder:
            (_) =>
                const MapAddressPickerScreen(title: 'Select Current Location'),
      ),
    );

    if (!mounted || selectedAddress == null || selectedAddress.trim().isEmpty) {
      return;
    }

    await _persistLocation(selectedAddress.trim(), updateState: true);
  }

  List<HomeCategoryEntity> get _availableCategories {
    return _homeCubit.state.when(
      initial: () => const <HomeCategoryEntity>[],
      loading: () => const <HomeCategoryEntity>[],
      loaded: (categories, _) => categories,
      error: (_) => const <HomeCategoryEntity>[],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _homeCubit),
        BlocProvider.value(value: _quickPicksCubit),
        BlocProvider.value(value: _basketCubit),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 110.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<BasketCubit, BasketState>(
                  builder:
                      (context, _) => HomeAppBar(
                        location: _currentLocation,
                        isLocationLoading: _isResolvingLocation,
                        onLocationTap: _onLocationTap,
                        cartCount: _basketCubit.totalItemsCount,
                        onCartTap: () => context.pushNamed('basket'),
                      ),
                ),
                SizedBox(height: 16.h),
                const HomeBannersSection(),
                HomeCategoriesSection(
                  selectedCategoryIndex: _selectedCategoryIndex,
                  onCategoryTap: _onCategoryTap,
                  homeCubit: _homeCubit,
                ),
                SizedBox(height: 24.h),
                HomeQuickPicksSection(
                  basketCubit: _basketCubit,
                  servicesCubit: _quickPicksCubit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
