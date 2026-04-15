import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:laundry/core/di/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/core/services/local_storage_service.dart';
import 'package:laundry/features/wallet/data/data_sources/wallet_remote_data_source.dart';
import 'package:laundry/features/wallet/domain/repos/wallet_repo.dart';
import 'package:laundry/features/wallet/data/repos/wallet_repo_impl.dart';
import 'package:laundry/features/wallet/presentation/cubit/wallet_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  //============================================================
  // External
  //============================================================
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Connectivity());

  //============================================================
  // Core - Services
  //============================================================
  getIt.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(prefs: getIt()),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: getIt()),
  );

  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(localStorageService: getIt()),
  );

  //============================================================
  // Features - Home
  //============================================================
  registerHomeFeatureDependencies(getIt);

  //============================================================
  // Features - Auth
  //============================================================
  registerAuthFeatureDependencies(getIt);

  //============================================================
  // Features - Basket
  //============================================================
  registerBasketFeatureDependencies(getIt);

  //============================================================
  // Features - OnBoarding
  //============================================================
  registerOnBoardingFeatureDependencies(getIt);

  //============================================================
  // Features - Orders
  //============================================================
  registerOrdersFeatureDependencies(getIt);

  // ============================================================
  // Features - Wallet
  //============================================================
  getIt.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<WalletRepo>(
    () => WalletRepoImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );
  getIt.registerFactory(() => WalletCubit(repo: getIt()));

  //============================================================
  // Features - Profile
  //============================================================
  registerProfileFeatureDependencies(getIt);
}
