import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/login_request.dart';
import 'package:flutter_starter_kit/features/auth/presentation/providers/auth_providers.dart';

class LoginState {
  final bool isLoading;
  final bool obscurePassword;
  final String? error;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginState({
    this.isLoading = false,
    this.obscurePassword = true,
    this.error,
    required this.usernameController,
    required this.passwordController,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? obscurePassword,
    String? error,
    TextEditingController? usernameController,
    TextEditingController? passwordController,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      error: error,
      usernameController: usernameController ?? this.usernameController,
      passwordController: passwordController ?? this.passwordController,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final Ref _ref;

  LoginNotifier(this._ref)
      : super(LoginState(
          usernameController: TextEditingController(),
          passwordController: TextEditingController(),
        ));

  void togglePasswordVisibility() {
    state = state.copyWith(
      obscurePassword: !state.obscurePassword,
    );
  }

  Future<void> login() async {
    if (state.usernameController.text.isEmpty ||
        state.passwordController.text.isEmpty) {
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final request = LoginRequest(
        username: state.usernameController.text,
        password: state.passwordController.text,
      );
      await _ref.read(authNotifierProvider.notifier).login(request);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _ref.read(authNotifierProvider.notifier).loginWithGoogle();
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _ref.read(authNotifierProvider.notifier).loginWithFacebook();
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loginWithApple() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _ref.read(authNotifierProvider.notifier).loginWithApple();
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loginWithPhone() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _ref.read(authNotifierProvider.notifier).loginWithPhone();
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    state.usernameController.dispose();
    state.passwordController.dispose();
    super.dispose();
  }
}

// Provider cho LoginNotifier
final loginNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref);
});
