import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/errors/onboarding_errors.dart';

part 'onboarding_state.freezed.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(false) bool isLoading,
    @Default(false) bool isCompleted,
    @Default(<String>{}) Set<String> selectedInterests,
    @Default(<String>{}) Set<String> selectedGoals,
    @Default(false) bool isCompleting,
    OnboardingError? error,
  }) = _OnboardingState;
}
