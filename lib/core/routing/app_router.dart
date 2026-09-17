import 'package:factopro/features/authentication/view/user_store_registration.dart';
import 'package:factopro/features/dashboard/view/dashboard_screen.dart';
import 'package:factopro/features/onboarding/view/onboarding_screen.dart';
import 'package:factopro/features/settings/view/settings_screen.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  splash,
  onboarding,
  auth,
  settings,
  dashboard,
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
      path: '/auth',
      name: AppRoute.auth.name,
      builder: (context, state) => AuthScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: AppRoute.settings.name,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: AppRoute.dashboard.name,
      builder: (context, state) => const DashboardScreen(),
    ),
  ],
);