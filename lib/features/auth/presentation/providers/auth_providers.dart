import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/core/di/dependency_injection.dart';
import 'package:flutter_starter_kit/core/network/api_service.dart';
import 'package:flutter_starter_kit/core/services/secure_storage_service.dart';
import 'package:flutter_starter_kit/features/auth/data/models/user_model.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/auth_state.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/auth_repository_impl.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_starter_kit/features/auth/presentation/providers/auth_notifier.dart';

/// Auth feature providers

// Core service providers
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return getIt<SecureStorageService>();
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return getIt<ApiService>();
});

// Repository providers
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRepositoryImpl(apiService);
});

// Use case providers
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginUseCase(authRepository);
});

// Global auth state provider
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return AuthNotifier(authRepository, secureStorage);
});

// Convenience providers for common auth state
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isAuthenticated;
});

final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authNotifierProvider).user;
});

final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authNotifierProvider).error;
});
