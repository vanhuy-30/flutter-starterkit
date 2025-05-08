import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/routes/routes.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  // Singleton instance
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  // Basic Navigation
  void push(BuildContext context, String route, {Object? extra}) {
    context.push(route, extra: extra);
  }

  void go(BuildContext context, String route, {Object? extra}) {
    context.go(route, extra: extra);
  }

  void pop(BuildContext context, [dynamic result]) {
    if (context.canPop()) {
      context.pop(result);
    }
  }

  void replace(BuildContext context, String route, {Object? extra}) {
    context.replace(route, extra: extra);
  }

  // Predefined routes
  void toSplash(BuildContext context) => go(context, Routes.splash);
  void toLogin(BuildContext context) => go(context, Routes.login);
  void toRegister(BuildContext context) => go(context, Routes.register);
  void toForgotPassword(BuildContext context) => push(context, Routes.forgotPassword);
  void toHome(BuildContext context) => go(context, Routes.home);

  // Navigation with parameters
  void pushWithParams(
    BuildContext context, 
    String route, 
    Map<String, String> params, {
    Object? extra,
  }) {
    String finalRoute = route;
    params.forEach((key, value) {
      finalRoute = finalRoute.replaceAll(':$key', value);
    });
    push(context, finalRoute, extra: extra);
  }

  void pushWithQuery(
    BuildContext context, 
    String route, 
    Map<String, String> queryParams, {
    Object? extra,
  }) {
    final uri = Uri(
      path: route,
      queryParameters: queryParams,
    );
    push(context, uri.toString(), extra: extra);
  }

  // Stack manipulation
  void popUntil(BuildContext context, String route) {
    while (context.canPop() && 
           GoRouterState.of(context).uri.path != route) {
      context.pop();
    }
  }

  void clearStackAndPush(BuildContext context, String route) {
    while (context.canPop()) {
      context.pop();
    }
    push(context, route);
  }

  // Results handling
  Future<T?> pushForResult<T>(BuildContext context, String route) {
    return context.push<T>(route);
  }

  // Deep linking
  Future<void> handleDeepLink(BuildContext context, String link) async {
    try {
      final uri = Uri.parse(link);
      push(context, uri.path, extra: uri.queryParameters);
    } catch (e) {
      debugPrint('Deep link error: $e');
    }
  }
}

// Extension for easier access
extension NavigationExt on BuildContext {
  NavigationService get nav => NavigationService();
}