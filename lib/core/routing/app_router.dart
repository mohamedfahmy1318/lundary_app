import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/routing/routing_names.dart';

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
import 'package:laundry/features/profile/presentation/pages/subscription_plans_page.dart';
import 'package:laundry/features/basket/presentation/pages/basket_page.dart';
import 'package:laundry/features/basket/presentation/pages/schedule_page.dart';
import 'package:laundry/features/basket/presentation/pages/payment_page.dart';
import 'package:laundry/features/basket/presentation/pages/order_success_page.dart';
import 'package:laundry/features/wallet/presentation/pages/wallet_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutingNames.onBoarding,
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
        builder: (context, state) =>
            const SchedulePage(type: ScheduleType.pickup),
      ),
      GoRoute(
        path: RoutingNames.deliverySchedule,
        name: 'deliverySchedule',
        builder: (context, state) =>
            const SchedulePage(type: ScheduleType.delivery),
      ),
      GoRoute(
        path: RoutingNames.payment,
        name: 'payment',
        builder: (context, state) => const PaymentPage(),
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
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.error}'))),
  );
}
