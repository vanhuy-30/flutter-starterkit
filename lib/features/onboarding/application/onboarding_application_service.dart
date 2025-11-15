import 'package:flutter_starter_kit/features/onboarding/domain/models/onboarding_state.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/errors/onboarding_errors.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/save_interests_usecase.dart';

/// Application service to orchestrate onboarding use cases
class OnboardingApplicationService {
  final GetOnboardingStatusUseCase _getStatusUseCase;
  final CompleteOnboardingUseCase _completeUseCase;
  final SaveInterestsUseCase _saveInterestsUseCase;

  OnboardingApplicationService(
    this._getStatusUseCase,
    this._completeUseCase,
    this._saveInterestsUseCase,
  );

  /// Initialize onboarding state
  Future<OnboardingState> initializeOnboarding() async {
    try {
      final isCompleted = await _getStatusUseCase.execute();
      return OnboardingState(
        isCompleted: isCompleted,
        isLoading: false,
      );
    } catch (e) {
      return OnboardingState(
        error: e is OnboardingError
            ? e
            : OnboardingLoadError(
                message: 'Lỗi không xác định',
                details: e.toString(),
              ),
        isLoading: false,
      );
    }
  }

  /// Complete onboarding with interests
  Future<OnboardingState> completeOnboardingWithInterests({
    required Set<String> interests,
  }) async {
    try {
      // Save interests first
      if (interests.isNotEmpty) {
        await _saveInterestsUseCase.execute(interests);
      }

      // Complete onboarding
      await _completeUseCase.execute();

      return OnboardingState(
        isCompleted: true,
        selectedInterests: interests,
      );
    } catch (e) {
      return OnboardingState(
        error: e is OnboardingError
            ? e
            : OnboardingSaveError(
                message: 'Không thể hoàn thành onboarding',
                details: e.toString(),
              ),
        isCompleting: false,
      );
    }
  }

  /// Save interests individually
  Future<void> saveInterests(Set<String> interests) async {
    await _saveInterestsUseCase.execute(interests);
  }

  /// Check onboarding state
  Future<bool> isOnboardingCompleted() async {
    return _getStatusUseCase.execute();
  }
}
