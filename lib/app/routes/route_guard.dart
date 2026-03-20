import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_starter_kit/app/routes/route_paths.dart';
import 'package:flutter_starter_kit/core/services/preferences_service.dart';
import 'package:flutter_starter_kit/features/auth/presentation/state/auth_providers.dart';

/// Guard result types
enum GuardResult {
  allow, // Allow access
  redirect, // Redirect to another route
  block, // Block access
}

/// Guard check result with action and message
class GuardCheckResult {
  final GuardResult result;
  final String? redirectPath;
  final String? message;

  const GuardCheckResult({
    required this.result,
    this.redirectPath,
    this.message,
  });

  const GuardCheckResult.allow() : this(result: GuardResult.allow);
  const GuardCheckResult.redirect(String path, {String? message})
      : this(
            result: GuardResult.redirect, redirectPath: path, message: message);
  const GuardCheckResult.block({String? message})
      : this(result: GuardResult.block, message: message);
}

/// Base class for all guards
abstract class BaseGuard {
  String get name;
  int get priority; // Lower number = higher priority

  Future<GuardCheckResult> checkAccess(
    BuildContext context,
    GoRouterState state,
    String route,
  );

  bool appliesTo(String route);
}

/// Authentication guard - checks if user is logged in
class AuthGuard extends BaseGuard {
  @override
  String get name => 'AuthGuard';

  @override
  int get priority => 1;

  /// Check if user is logged in using context
  bool isLoggedIn(BuildContext context) {
    try {
      final container = ProviderScope.containerOf(context);
      final authState = container.read(authNotifierProvider);
      return authState.isAuthenticated;
    } catch (e) {
      // If there's any error accessing auth state, assume not logged in
      return false;
    }
  }

  /// Check if onboarding is completed
  bool get isOnboardingCompleted {
    return PreferencesService().getOnboardingCompleted();
  }

  @override
  bool appliesTo(String route) {
    // Routes that require authentication
    final protectedRoutes = {
      Routes.home,
      Routes.search,
      Routes.settings,
      Routes.profile,
      Routes.language,
    };
    return protectedRoutes.contains(route);
  }

  @override
  Future<GuardCheckResult> checkAccess(
    BuildContext context,
    GoRouterState state,
    String route,
  ) async {
    if (!isLoggedIn(context)) {
      return const GuardCheckResult.redirect(
        Routes.login,
        message: 'You need to login to access this page',
      );
    }

    return const GuardCheckResult.allow();
  }
}

/// Route guard manager - manages all guards
class RouteGuard {
  RouteGuard._();

  static final RouteGuard _instance = RouteGuard._();
  static RouteGuard get instance => _instance;

  // List of all guards
  final List<BaseGuard> _guards = [
    AuthGuard(),
  ];

  /// Redirect function for GoRouter (handles sync guards only)
  String? redirect(BuildContext context, GoRouterState state) {
    final currentLocation = state.uri.path;

    // Handle splash route - redirect based on auth state
    if (currentLocation == Routes.splash) {
      final authGuard = AuthGuard();
      if (!authGuard.isOnboardingCompleted) {
        return Routes.onboarding;
      } else if (!authGuard.isLoggedIn(context)) {
        return Routes.login;
      } else {
        return Routes.home;
      }
    }

    // Check onboarding completion first
    final authGuard = AuthGuard();
    if (!authGuard.isOnboardingCompleted &&
        currentLocation != Routes.onboarding) {
      return Routes.onboarding;
    }

    // If onboarding completed but not logged in, redirect to login
    if (authGuard.isOnboardingCompleted &&
        !authGuard.isLoggedIn(context) &&
        currentLocation == Routes.onboarding) {
      return Routes.login;
    }

    // Handle auth guard
    if (authGuard.appliesTo(currentLocation)) {
      if (!authGuard.isLoggedIn(context)) {
        return Routes.login;
      }
    }

    // If logged in and on login page, redirect to home
    if (authGuard.isLoggedIn(context) && currentLocation == Routes.login) {
      return Routes.home;
    }

    return null;
  }

  /// Navigate with guard check
  Future<void> navigateWithGuard(
    BuildContext context,
    String route, {
    Object? extra,
  }) async {
    final result = await _checkAllGuards(context, route);

    if (!context.mounted) return;

    if (result.result == GuardResult.allow) {
      context.go(route, extra: extra);
    } else if (result.result == GuardResult.redirect) {
      context.go(result.redirectPath!, extra: extra);
    } else if (result.result == GuardResult.block) {
      if (result.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.message!)),
        );
      }
    }
  }

  /// Push with guard check
  Future<void> pushWithGuard(
    BuildContext context,
    String route, {
    Object? extra,
  }) async {
    final result = await _checkAllGuards(context, route);

    if (!context.mounted) return;

    if (result.result == GuardResult.allow) {
      unawaited(context.push(route, extra: extra));
    } else if (result.result == GuardResult.redirect) {
      context.go(result.redirectPath!, extra: extra);
    } else if (result.result == GuardResult.block) {
      if (result.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.message!)),
        );
      }
    }
  }

  /// Check all guards for a route
  Future<GuardCheckResult> _checkAllGuards(
    BuildContext context,
    String route,
  ) async {
    // Sort guards by priority
    final sortedGuards = List<BaseGuard>.from(_guards)
      ..sort((a, b) => a.priority.compareTo(b.priority));

    // Check each guard
    for (final guard in sortedGuards) {
      if (guard.appliesTo(route)) {
        final result = await guard.checkAccess(
          context,
          GoRouterState.of(context),
          route,
        );

        if (result.result != GuardResult.allow) {
          return result;
        }
      }
    }

    return const GuardCheckResult.allow();
  }

  /// Add new guard
  void addGuard(BaseGuard guard) {
    _guards.add(guard);
  }

  /// Remove guard by name
  void removeGuard(String guardName) {
    _guards.removeWhere((guard) => guard.name == guardName);
  }
}
