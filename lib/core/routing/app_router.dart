import 'package:factopro/features/authentication/view/user_store_registration.dart';
import 'package:factopro/features/onboarding/view/onboarding_screen.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  splash,
  onboarding,
  auth,
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
  ],
);