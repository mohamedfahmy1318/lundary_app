import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:laundry/features/basket/domain/repos/basket_repo.dart';
import 'package:laundry/features/onboarding/data/data_sources/on_boarding_remote_data_source.dart';
import 'package:laundry/features/onboarding/data/repos/on_boarding_repo_impl.dart';
import 'package:laundry/features/onboarding/domain/repos/on_boarding_repo.dart';
import 'package:laundry/features/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:laundry/features/profile/presentation/cubit/support_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/core/services/local_storage_service.dart';
import 'package:laundry/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:laundry/features/home/data/repos/home_repo_impl.dart';
import 'package:laundry/features/home/domain/repos/home_repo.dart';
import 'package:laundry/features/home/presentation/cubit/home_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_cubit.dart';
import 'package:laundry/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:laundry/features/auth/data/repos/auth_repo_impl.dart';
import 'package:laundry/features/auth/domain/repos/auth_repo.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:laundry/features/basket/data/data_sources/basket_remote_data_source.dart';
import 'package:laundry/features/basket/data/repos/basket_repo_impl.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_cubit.dart';
import 'package:laundry/features/orders/data/data_sources/orders_remote_data_source.dart';
import 'package:laundry/features/orders/data/repos/orders_repo_impl.dart';
import 'package:laundry/features/orders/domain/repos/orders_repo.dart';
import 'package:laundry/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:laundry/features/wallet/data/data_sources/wallet_remote_data_source.dart';
import 'package:laundry/features/wallet/domain/repos/wallet_repo.dart';
import 'package:laundry/features/wallet/data/repos/wallet_repo_impl.dart';
import 'package:laundry/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:laundry/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';
import 'package:laundry/features/profile/data/repos/profile_repo_impl.dart';
import 'package:laundry/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:laundry/features/profile/presentation/cubit/change_password_cubit.dart';
import 'package:laundry/features/profile/presentation/cubit/update_profile_cubit.dart';
import 'package:laundry/features/profile/presentation/cubit/subscriptions_cubit.dart';

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
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );
  getIt.registerFactory(() => HomeCubit(homeRepo: getIt()));
  getIt.registerFactory(() => CategoryServicesCubit(homeRepo: getIt()));

  //============================================================
  // Features - Auth
  //============================================================
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
      localStorageService: getIt(),
    ),
  );
  getIt.registerFactory(() => AuthCubit(authRepo: getIt()));

  //============================================================
  // Features - Basket
  //============================================================
  getIt.registerLazySingleton<BasketRemoteDataSource>(
    () => BasketRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<BasketRepo>(
    () => BasketRepoImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );
  // Singleton so the cart persists across all screens
  getIt.registerLazySingleton(() => BasketCubit(basketRepo: getIt()));

  //============================================================
  // Features - Orders
  //============================================================
  getIt.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<OrdersRepo>(
    () => OrdersRepoImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );
  getIt.registerFactory(() => OrdersCubit(ordersRepo: getIt()));

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
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  //============================================================
  // Features - OnBoarding
  //============================================================
  getIt.registerLazySingleton<OnBoardingRemoteDataSource>(
    () => OnBoardingRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<OnBoardingRepo>(
    () => OnBoardingRepoImpl(remoteDataSource: getIt(), networkInfo: getIt()),
  );

  getIt.registerFactory(() => ProfileCubit(repo: getIt()));
  getIt.registerFactory(() => ChangePasswordCubit(getIt()));
  getIt.registerFactory(() => SubscriptionsCubit(repo: getIt()));
  getIt.registerFactory(() => SupportCubit(repo: getIt()));
  getIt.registerFactory(() => OnBoardingCubit(repo: getIt()));
  getIt.registerFactory(() => UpdateProfileCubit(repo: getIt()));
}
