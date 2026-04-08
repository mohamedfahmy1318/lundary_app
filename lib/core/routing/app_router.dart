import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/core/routing/routing_names.dart';
import 'package:laundry/core/services/local_storage_service.dart';

import 'package:laundry/features/home/presentation/screens/main_screen.dart';
import 'package:laundry/features/onboarding/presentation/screens/on_boarding_screen.dart';
import 'package:laundry/features/auth/presentation/screens/login_screen.dart';
import 'package:laundry/features/auth/presentation/screens/register_screen.dart';
import 'package:laundry/features/auth/presentation/screens/verification_screen.dart';
import 'package:laundry/features/select_address/presentation/screens/select_address_screen.dart';
import 'package:laundry/features/orders/presentation/pages/order_details_page.dart';
import 'package:laundry/features/orders/data/models/order_model.dart';
import 'package:laundry/features/profile/presentation/pages/manage_account_page.dart';
import 'package:laundry/features/profile/presentation/pages/support_page.dart';
import 'package:laundry/features/profile/presentation/pages/new_ticket_page.dart';
import 'package:laundry/features/profile/presentation/pages/ticket_details_page.dart';
import 'package:laundry/features/profile/presentation/pages/subscription_plans_page.dart';
import 'package:laundry/features/basket/presentation/pages/basket_page.dart';
import 'package:laundry/features/basket/presentation/pages/schedule_page.dart';
import 'package:laundry/features/basket/presentation/pages/payment_page.dart';
import 'package:laundry/features/basket/presentation/pages/order_success_page.dart';
import 'package:laundry/features/wallet/presentation/pages/wallet_page.dart';
import 'package:laundry/features/home/presentation/screens/category_services_page.dart';
import 'package:laundry/features/home/data/models/category_model.dart';

class AppRouter {
  static String get _initialLocation {
    final storage = getIt<LocalStorageService>();
    if (storage.isLoggedIn()) {
      return RoutingNames.main;
    }
    return RoutingNames.onBoarding;
  }

  static final GoRouter router = GoRouter(
    initialLocation: _initialLocation,
    debugLogDiagnostics: true,
    routes: [
      //onBoarding
      GoRoute(
        path: RoutingNames.onBoarding,
        name: 'onBoarding',
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: RoutingNames.main,
        name: 'main',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: RoutingNames.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutingNames.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RoutingNames.verification,
        name: 'verification',
        builder: (context, state) => const VerificationScreen(),
      ),
      GoRoute(
        path: RoutingNames.selectAddress,
        name: 'selectAddress',
        builder: (context, state) => const SelectAddressScreen(),
      ),
      GoRoute(
        path: RoutingNames.orderDetails,
        name: 'orderDetails',
        builder: (context, state) {
          final order = state.extra as OrderModel;
          return OrderDetailsPage(order: order);
        },
      ),
      GoRoute(
        path: RoutingNames.manageAccount,
        name: 'manageAccount',
        builder: (context, state) => const ManageAccountPage(),
      ),
      GoRoute(
        path: RoutingNames.support,
        name: 'support',
        builder: (context, state) => const SupportPage(),
      ),
      GoRoute(
        path: RoutingNames.newTicket,
        name: 'newTicket',
        builder: (context, state) => const NewTicketPage(),
      ),
      GoRoute(
        path: RoutingNames.ticketDetails,
        name: 'ticketDetails',
        builder: (context, state) {
          final ticketId = int.tryParse(state.pathParameters['ticketId'] ?? '');
          if (ticketId == null) {
            return const Scaffold(
              body: Center(child: Text('Invalid ticket id')),
            );
          }
          return TicketDetailsPage(ticketId: ticketId);
        },
      ),
      GoRoute(
        path: RoutingNames.subscriptionPlans,
        name: 'subscriptionPlans',
        builder: (context, state) => const SubscriptionPlansPage(),
      ),
      GoRoute(
        path: RoutingNames.basket,
        name: 'basket',
        builder: (context, state) => const BasketPage(),
      ),
      GoRoute(
        path: RoutingNames.pickupSchedule,
        name: 'pickupSchedule',
        builder:
            (context, state) => const SchedulePage(type: ScheduleType.pickup),
      ),
      GoRoute(
        path: RoutingNames.deliverySchedule,
        name: 'deliverySchedule',
        builder:
            (context, state) => SchedulePage(
              type: ScheduleType.delivery,
              pickupData: state.extra as Map<String, String>?,
            ),
      ),
      GoRoute(
        path: RoutingNames.payment,
        name: 'payment',
        builder:
            (context, state) =>
                PaymentPage(scheduleData: state.extra as Map<String, String>?),
      ),
      GoRoute(
        path: RoutingNames.orderSuccess,
        name: 'orderSuccess',
        builder: (context, state) => const OrderSuccessPage(),
      ),
      GoRoute(
        path: RoutingNames.wallet,
        name: 'wallet',
        builder: (context, state) => const WalletPage(),
      ),
      GoRoute(
        path: RoutingNames.categoryServices,
        name: 'categoryServices',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final categories = extra['categories'] as List<CategoryModel>;
          final selectedIndex = extra['selectedIndex'] as int? ?? 0;
          return CategoryServicesPage(
            categories: categories,
            initialCategoryIndex: selectedIndex,
          );
        },
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(child: Text('Page not found: ${state.error}')),
        ),
  );
}
