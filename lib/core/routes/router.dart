import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/routes/routes.dart';
import 'package:flutter_starter_kit/presentation/pages/home_page.dart';
import 'package:flutter_starter_kit/presentation/pages/login/login_page.dart';
import 'package:flutter_starter_kit/presentation/pages/not_found_page.dart';
import 'package:flutter_starter_kit/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

GoRouter router() {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: Routes.splash,
    // redirect: (context, state) {
      // final isLoggedIn = false;
      // final isLoggingIn = state.location == '/login';

      // if (!isLoggedIn && !isLoggingIn) {
      //   return '/login';
      // }
      // return null;
    // },
    routes: [
      GoRoute(
        path: Routes.splash,
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: Routes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.home,
        name: 'home',
        builder: (context, state) => HomePage(title: 'app_name'.tr()),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
