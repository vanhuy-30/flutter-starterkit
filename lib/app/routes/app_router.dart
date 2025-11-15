import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/routes/route_paths.dart';
import 'package:flutter_starter_kit/app/routes/route_guard.dart';
import 'package:flutter_starter_kit/features/auth/presentation/pages/register_page.dart';
import 'package:flutter_starter_kit/features/home/presentation/pages/home_page.dart';
import 'package:flutter_starter_kit/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_starter_kit/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter_starter_kit/features/search/presentation/pages/search_page.dart';
import 'package:flutter_starter_kit/features/main/presentation/pages/main_shell_page.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter_starter_kit/shared/pages/not_found_page.dart';
import 'package:flutter_starter_kit/shared/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: Routes.splash,
  redirect: RouteGuard.instance.redirect,
  routes: [
    GoRoute(
      path: Routes.splash,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: Routes.onboarding,
      name: 'onboarding',
      builder: (context, state) => OnboardingPage(
        onComplete: () {
          context.go(Routes.login);
        },
      ),
    ),
    GoRoute(
      path: Routes.login,
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: Routes.register,
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShellPage(navigationShell: navigationShell),
      branches: [
        // Home tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              name: 'home',
              builder: (context, state) => HomePage(title: 'app_name'.tr()),
            ),
          ],
        ),
        // Search tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.search,
              name: 'search',
              builder: (context, state) => const SearchPage(),
            ),
          ],
        ),
        // Settings tab
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              name: 'settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const NotFoundPage(),
);
