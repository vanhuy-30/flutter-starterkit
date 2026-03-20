import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/errors/onboarding_errors.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/models/onboarding_state.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/save_interests_usecase.dart';

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final GetOnboardingStatusUseCase _getStatusUseCase;
  final CompleteOnboardingUseCase _completeUseCase;
  final SaveInterestsUseCase _saveInterestsUseCase;

  OnboardingNotifier(
    this._getStatusUseCase,
    this._completeUseCase,
    this._saveInterestsUseCase,
  ) : super(const OnboardingState());

  /// Initialize onboarding status
  Future<void> initialize() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final isCompleted = await _getStatusUseCase.execute();
      state = state.copyWith(
        isCompleted: isCompleted,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e is OnboardingError
            ? e
            : OnboardingLoadError(
                message: 'Unknown error',
                details: e.toString(),
              ),
        isLoading: false,
      );
    }
  }

  /// Toggle interest selection
  void toggleInterest(String interest) {
    final newInterests = Set<String>.from(state.selectedInterests);
    if (newInterests.contains(interest)) {
      newInterests.remove(interest);
    } else {
      newInterests.add(interest);
    }

    state = state.copyWith(
      selectedInterests: newInterests,
    );
  }

  /// Toggle goal selection
  void toggleGoal(String goal) {
    final newGoals = Set<String>.from(state.selectedGoals);
    if (newGoals.contains(goal)) {
      newGoals.remove(goal);
    } else {
      newGoals.add(goal);
    }

    state = state.copyWith(
      selectedGoals: newGoals,
    );
  }

  /// Complete onboarding
  Future<void> completeOnboarding() async {
    state = state.copyWith(isCompleting: true, error: null);

    try {
      // Save selected interests if any
      if (state.selectedInterests.isNotEmpty) {
        await _saveInterestsUseCase.execute(state.selectedInterests);
      }

      // Mark onboarding as completed
      await _completeUseCase.execute();

      state = state.copyWith(
        isCompleted: true,
        isCompleting: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e is OnboardingError
            ? e
            : OnboardingSaveError(
                message: 'Unable to complete onboarding',
                details: e.toString(),
              ),
        isCompleting: false,
      );
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}
