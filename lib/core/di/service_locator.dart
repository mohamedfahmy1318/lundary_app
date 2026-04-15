import 'package:get_it/get_it.dart';
import 'package:laundry/core/network/api_client.dart';
import 'package:laundry/core/network/network_info.dart';
import 'package:laundry/core/services/local_storage_service.dart';
import 'package:laundry/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:laundry/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:laundry/features/auth/data/repos/auth_repo_impl.dart';
import 'package:laundry/features/auth/domain/repos/auth_repo.dart';
import 'package:laundry/features/auth/domain/usecases/logout_auth_usecase.dart';
import 'package:laundry/features/auth/domain/usecases/request_login_otp_usecase.dart';
import 'package:laundry/features/auth/domain/usecases/request_register_otp_usecase.dart';
import 'package:laundry/features/auth/domain/usecases/resend_auth_otp_usecase.dart';
import 'package:laundry/features/auth/domain/usecases/verify_auth_otp_usecase.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:laundry/features/basket/data/data_sources/basket_local_data_source.dart';
import 'package:laundry/features/basket/data/data_sources/basket_remote_data_source.dart';
import 'package:laundry/features/basket/data/repos/basket_repo_impl.dart';
import 'package:laundry/features/basket/domain/repos/basket_repo.dart';
import 'package:laundry/features/basket/domain/usecases/create_order_usecase.dart';
import 'package:laundry/features/basket/domain/usecases/get_timeslots_usecase.dart';
import 'package:laundry/features/basket/presentation/cubit/basket_cubit.dart';
import 'package:laundry/features/basket/presentation/cubit/timeslots_cubit.dart';
import 'package:laundry/features/home/data/data_sources/home_local_data_source.dart';
import 'package:laundry/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:laundry/features/home/data/repos/home_repo_impl.dart';
import 'package:laundry/features/home/domain/repos/home_repo.dart';
import 'package:laundry/features/home/domain/usecases/get_home_banners_usecase.dart';
import 'package:laundry/features/home/domain/usecases/get_home_categories_usecase.dart';
import 'package:laundry/features/home/domain/usecases/get_home_services_usecase.dart';
import 'package:laundry/features/home/domain/usecases/get_top_home_services_usecase.dart';
import 'package:laundry/features/home/presentation/cubit/category_services_cubit.dart';
import 'package:laundry/features/home/presentation/cubit/home_cubit.dart';
import 'package:laundry/features/onboarding/data/data_sources/on_boarding_local_data_source.dart';
import 'package:laundry/features/onboarding/data/data_sources/on_boarding_remote_data_source.dart';
import 'package:laundry/features/onboarding/data/repos/on_boarding_repo_impl.dart';
import 'package:laundry/features/onboarding/domain/repos/on_boarding_repo.dart';
import 'package:laundry/features/onboarding/domain/usecases/get_on_boarding_slides_usecase.dart';
import 'package:laundry/features/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:laundry/features/orders/data/data_sources/orders_local_data_source.dart';
import 'package:laundry/features/orders/data/data_sources/orders_remote_data_source.dart';
import 'package:laundry/features/orders/data/repos/orders_repo_impl.dart';
import 'package:laundry/features/orders/domain/repos/orders_repo.dart';
import 'package:laundry/features/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:laundry/features/orders/domain/usecases/get_order_by_id_usecase.dart';
import 'package:laundry/features/orders/domain/usecases/get_order_statistics_usecase.dart';
import 'package:laundry/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:laundry/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:laundry/features/profile/data/data_sources/profile_local_data_source.dart';
import 'package:laundry/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:laundry/features/profile/data/repos/profile_repo_impl.dart';
import 'package:laundry/features/profile/domain/repos/profile_repo.dart';
import 'package:laundry/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/close_ticket_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/create_ticket_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/delete_account_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_my_subscriptions_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_subscription_plans_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_ticket_categories_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_ticket_details_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_ticket_priorities_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_ticket_statuses_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/get_tickets_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/logout_profile_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/reply_to_ticket_usecase.dart';
import 'package:laundry/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:laundry/features/profile/presentation/cubit/change_password_cubit.dart';
import 'package:laundry/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:laundry/features/profile/presentation/cubit/subscriptions_cubit.dart';
import 'package:laundry/features/profile/presentation/cubit/support_cubit.dart';
import 'package:laundry/features/profile/presentation/cubit/ticket_details_cubit.dart';
import 'package:laundry/features/profile/presentation/cubit/update_profile_cubit.dart';

void registerHomeFeatureDependencies(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(apiClient: serviceLocator<ApiClient>()),
  );
  serviceLocator.registerLazySingleton<HomeLocalDataSource>(
    HomeLocalDataSourceImpl.new,
  );
  serviceLocator.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(
      remoteDataSource: serviceLocator<HomeRemoteDataSource>(),
      localDataSource: serviceLocator<HomeLocalDataSource>(),
      networkInfo: serviceLocator<NetworkInfo>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => GetHomeCategoriesUseCase(homeRepo: serviceLocator<HomeRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => GetHomeBannersUseCase(homeRepo: serviceLocator<HomeRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => GetHomeServicesUseCase(homeRepo: serviceLocator<HomeRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => GetTopHomeServicesUseCase(homeRepo: serviceLocator<HomeRepo>()),
  );

  serviceLocator.registerFactory(
    () => HomeCubit(
      getHomeCategoriesUseCase: serviceLocator<GetHomeCategoriesUseCase>(),
      getHomeBannersUseCase: serviceLocator<GetHomeBannersUseCase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => CategoryServicesCubit(
      getHomeServicesUseCase: serviceLocator<GetHomeServicesUseCase>(),
      getTopHomeServicesUseCase: serviceLocator<GetTopHomeServicesUseCase>(),
    ),
  );
}

void registerAuthFeatureDependencies(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: serviceLocator<ApiClient>()),
  );
  serviceLocator.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      localStorageService: serviceLocator<LocalStorageService>(),
    ),
  );
  serviceLocator.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      remoteDataSource: serviceLocator<AuthRemoteDataSource>(),
      localDataSource: serviceLocator<AuthLocalDataSource>(),
      networkInfo: serviceLocator<NetworkInfo>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => RequestLoginOtpUseCase(authRepo: serviceLocator<AuthRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => RequestRegisterOtpUseCase(authRepo: serviceLocator<AuthRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => VerifyAuthOtpUseCase(authRepo: serviceLocator<AuthRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => ResendAuthOtpUseCase(authRepo: serviceLocator<AuthRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => LogoutAuthUseCase(authRepo: serviceLocator<AuthRepo>()),
  );

  serviceLocator.registerFactory(
    () => AuthCubit(
      requestLoginOtpUseCase: serviceLocator<RequestLoginOtpUseCase>(),
      requestRegisterOtpUseCase: serviceLocator<RequestRegisterOtpUseCase>(),
      verifyAuthOtpUseCase: serviceLocator<VerifyAuthOtpUseCase>(),
      resendAuthOtpUseCase: serviceLocator<ResendAuthOtpUseCase>(),
      logoutAuthUseCase: serviceLocator<LogoutAuthUseCase>(),
    ),
  );
}

void registerBasketFeatureDependencies(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<BasketRemoteDataSource>(
    () => BasketRemoteDataSourceImpl(apiClient: serviceLocator<ApiClient>()),
  );
  serviceLocator.registerLazySingleton<BasketLocalDataSource>(
    BasketLocalDataSourceImpl.new,
  );
  serviceLocator.registerLazySingleton<BasketRepo>(
    () => BasketRepoImpl(
      remoteDataSource: serviceLocator<BasketRemoteDataSource>(),
      localDataSource: serviceLocator<BasketLocalDataSource>(),
      networkInfo: serviceLocator<NetworkInfo>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => CreateOrderUseCase(basketRepo: serviceLocator<BasketRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => GetTimeslotsUseCase(basketRepo: serviceLocator<BasketRepo>()),
  );

  // Keep the cart state across screens in the same app session.
  serviceLocator.registerLazySingleton(
    () => BasketCubit(createOrderUseCase: serviceLocator<CreateOrderUseCase>()),
  );
  serviceLocator.registerFactory(
    () => TimeslotsCubit(
      getTimeslotsUseCase: serviceLocator<GetTimeslotsUseCase>(),
    ),
  );
}

void registerOnBoardingFeatureDependencies(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<OnBoardingRemoteDataSource>(
    () =>
        OnBoardingRemoteDataSourceImpl(apiClient: serviceLocator<ApiClient>()),
  );
  serviceLocator.registerLazySingleton<OnBoardingLocalDataSource>(
    OnBoardingLocalDataSourceImpl.new,
  );
  serviceLocator.registerLazySingleton<OnBoardingRepo>(
    () => OnBoardingRepoImpl(
      remoteDataSource: serviceLocator<OnBoardingRemoteDataSource>(),
      localDataSource: serviceLocator<OnBoardingLocalDataSource>(),
      networkInfo: serviceLocator<NetworkInfo>(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GetOnBoardingSlidesUseCase(
      onBoardingRepo: serviceLocator<OnBoardingRepo>(),
    ),
  );
  serviceLocator.registerFactory(
    () => OnBoardingCubit(
      getOnBoardingSlidesUseCase: serviceLocator<GetOnBoardingSlidesUseCase>(),
    ),
  );
}

void registerOrdersFeatureDependencies(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSourceImpl(apiClient: serviceLocator<ApiClient>()),
  );
  serviceLocator.registerLazySingleton<OrdersLocalDataSource>(
    OrdersLocalDataSourceImpl.new,
  );
  serviceLocator.registerLazySingleton<OrdersRepo>(
    () => OrdersRepoImpl(
      remoteDataSource: serviceLocator<OrdersRemoteDataSource>(),
      localDataSource: serviceLocator<OrdersLocalDataSource>(),
      networkInfo: serviceLocator<NetworkInfo>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => GetOrdersUseCase(ordersRepo: serviceLocator<OrdersRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => GetOrderByIdUseCase(ordersRepo: serviceLocator<OrdersRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => CancelOrderUseCase(ordersRepo: serviceLocator<OrdersRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => GetOrderStatisticsUseCase(ordersRepo: serviceLocator<OrdersRepo>()),
  );

  serviceLocator.registerFactory(
    () => OrdersCubit(
      getOrdersUseCase: serviceLocator<GetOrdersUseCase>(),
      cancelOrderUseCase: serviceLocator<CancelOrderUseCase>(),
    ),
  );
}

void registerProfileFeatureDependencies(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiClient: serviceLocator<ApiClient>()),
  );
  serviceLocator.registerLazySingleton<ProfileLocalDataSource>(
    ProfileLocalDataSourceImpl.new,
  );
  serviceLocator.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(
      remoteDataSource: serviceLocator<ProfileRemoteDataSource>(),
      localDataSource: serviceLocator<ProfileLocalDataSource>(),
      networkInfo: serviceLocator<NetworkInfo>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => GetProfileUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => UpdateProfileUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => ChangePasswordUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => GetTicketsUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => GetTicketDetailsUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => ReplyToTicketUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => CloseTicketUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => CreateTicketUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () =>
        GetTicketCategoriesUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () =>
        GetTicketPrioritiesUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => GetTicketStatusesUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () =>
        GetSubscriptionPlansUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => GetMySubscriptionsUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteAccountUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );
  serviceLocator.registerLazySingleton(
    () => LogoutProfileUseCase(profileRepo: serviceLocator<ProfileRepo>()),
  );

  serviceLocator.registerFactory(
    () => ProfileCubit(
      getProfileUseCase: serviceLocator<GetProfileUseCase>(),
      deleteAccountUseCase: serviceLocator<DeleteAccountUseCase>(),
      logoutProfileUseCase: serviceLocator<LogoutProfileUseCase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => ChangePasswordCubit(
      changePasswordUseCase: serviceLocator<ChangePasswordUseCase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => UpdateProfileCubit(
      updateProfileUseCase: serviceLocator<UpdateProfileUseCase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => SupportCubit(
      getTicketsUseCase: serviceLocator<GetTicketsUseCase>(),
      getTicketCategoriesUseCase: serviceLocator<GetTicketCategoriesUseCase>(),
      getTicketPrioritiesUseCase: serviceLocator<GetTicketPrioritiesUseCase>(),
      getTicketStatusesUseCase: serviceLocator<GetTicketStatusesUseCase>(),
      createTicketUseCase: serviceLocator<CreateTicketUseCase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => SubscriptionsCubit(
      getSubscriptionPlansUseCase:
          serviceLocator<GetSubscriptionPlansUseCase>(),
      getMySubscriptionsUseCase: serviceLocator<GetMySubscriptionsUseCase>(),
    ),
  );
  serviceLocator.registerFactory(
    () => TicketDetailsCubit(
      getTicketDetailsUseCase: serviceLocator<GetTicketDetailsUseCase>(),
      replyToTicketUseCase: serviceLocator<ReplyToTicketUseCase>(),
      closeTicketUseCase: serviceLocator<CloseTicketUseCase>(),
    ),
  );
}
