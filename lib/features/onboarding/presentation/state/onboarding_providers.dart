import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/providers/core_providers.dart';
import 'package:flutter_starter_kit/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/models/onboarding_state.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/save_interests_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/state/onboarding_notifier.dart';

/// Onboarding feature providers

// Repository providers
final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  final preferencesService = ref.watch(preferencesServiceProvider);
  return OnboardingRepositoryImpl(preferencesService);
});

// Use case providers
final getOnboardingStatusUseCaseProvider =
    Provider<GetOnboardingStatusUseCase>((ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return GetOnboardingStatusUseCase(repository);
});

final completeOnboardingUseCaseProvider =
    Provider<CompleteOnboardingUseCase>((ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return CompleteOnboardingUseCase(repository);
});

final saveInterestsUseCaseProvider = Provider<SaveInterestsUseCase>((ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return SaveInterestsUseCase(repository);
});

// View model providers
final onboardingNotifierProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  final getStatusUseCase = ref.watch(getOnboardingStatusUseCaseProvider);
  final completeUseCase = ref.watch(completeOnboardingUseCaseProvider);
  final saveInterestsUseCase = ref.watch(saveInterestsUseCaseProvider);
  return OnboardingNotifier(
      getStatusUseCase, completeUseCase, saveInterestsUseCase);
});
