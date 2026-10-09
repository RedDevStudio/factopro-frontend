import 'package:factopro/core/routing/scaffold_with_nested_navigation.dart';
import 'package:factopro/features/authentication/view/login_screen.dart';
import 'package:factopro/features/authentication/view/phone_verification_screen.dart';
import 'package:factopro/features/authentication/view/user_store_registration.dart';
import 'package:factopro/features/dashboard/view/dashboard_screen.dart';
import 'package:factopro/features/invoices/view/invoice_issue_screen.dart';
import 'package:factopro/features/invoices/view/invoice_product_picker_screen.dart';
import 'package:factopro/features/invoices/view/invoices_screen.dart';
import 'package:factopro/features/invoices/widgets/invoice_issue_data.dart';
import 'package:factopro/features/notifications/view/notifications_screen.dart';
import 'package:factopro/features/onboarding/view/onboarding_screen.dart';
import 'package:factopro/features/products/view/edit_product_screen.dart';
import 'package:factopro/features/products/view/products_screen.dart';
import 'package:factopro/features/products/widgets/product_card_data.dart';
import 'package:factopro/features/settings/view/settings_screen.dart';
import 'package:factopro/features/subscription/view/subscription_payment_history_screen.dart';
import 'package:factopro/features/subscription/view/subscription_payment_success_screen.dart';
import 'package:factopro/features/subscription/view/subscription_screen.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  splash,
  onboarding,
  userStoreRegistration,
  phoneVerification,
  login,
  settings,
  invoices,
  products,
  dashboard,
  notifications,
  editProduct,
  subscription,
  subscriptionPaymentSuccess,
  subscriptionPaymentHistory,
  invoiceIssue,
  invoiceProductPicker,
}

final router = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    // GoRoute(
    //   path: '/',
    //   name: AppRoute.splash.name,
    //   builder: (context, state) => SplashScreen(),
    // ),
    GoRoute(
      path: '/onboarding',
      name: AppRoute.onboarding.name,
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/user-store-registration',
      name: AppRoute.userStoreRegistration.name,
      builder: (context, state) => UserStoreRegistration(),
    ),
    GoRoute(
      path: '/phone-verification',
      name: AppRoute.phoneVerification.name,
      builder: (context, state) => const PhoneVerificationScreen(),
    ),
    GoRoute(
      path: '/login',
      name: AppRoute.login.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/notifications',
      name: AppRoute.notifications.name,
      builder: (context, state) => NotificationsScreen(),
    ),
    GoRoute(
      path: '/edit-product',
      name: AppRoute.editProduct.name,
      builder: (context, state) =>
          EditProductScreen(product: state.extra as ProductCardData?),
    ),
    GoRoute(
      path: '/subscription',
      name: AppRoute.subscription.name,
      builder: (context, state) => const SubscriptionScreen(),
    ),
    GoRoute(
      path: '/subscription-payment-success',
      name: AppRoute.subscriptionPaymentSuccess.name,
      builder: (context, state) => const SubscriptionPaymentSuccessScreen(),
    ),
    GoRoute(
      path: '/subscription-payment-history',
      name: AppRoute.subscriptionPaymentHistory.name,
      builder: (context, state) => const SubscriptionPaymentHistoryScreen(),
    ),
    GoRoute(
      path: '/invoice-issue',
      name: AppRoute.invoiceIssue.name,
      builder: (context, state) => const InvoiceIssueScreen(),
    ),
    GoRoute(
      path: '/invoice-product-picker',
      name: AppRoute.invoiceProductPicker.name,
      builder: (context, state) => InvoiceProductPickerScreen(
        initialItems: state.extra as List<InvoiceIssueItemData>? ?? const [],
      ),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigationBar(
          navigationShell: navigationShell,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              name: AppRoute.settings.name,
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/invoices',
              name: AppRoute.invoices.name,
              builder: (context, state) => const InvoicesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/products',
              name: AppRoute.products.name,
              builder: (context, state) => const ProductsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              name: AppRoute.dashboard.name,
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
