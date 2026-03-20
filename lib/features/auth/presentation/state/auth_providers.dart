import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/providers/app_providers.dart';
import 'package:flutter_starter_kit/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/auth_state.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_starter_kit/features/auth/presentation/state/auth_notifier.dart';

/// Auth feature providers

// Repository providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
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

final currentUserProvider = Provider<UserEntity?>((ref) {
  return ref.watch(authNotifierProvider).user;
});

final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authNotifierProvider).error;
});
