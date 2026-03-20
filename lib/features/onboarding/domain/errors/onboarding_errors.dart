import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_errors.freezed.dart';

/// Base class for all onboarding errors
abstract class OnboardingError {
  const OnboardingError();
}

/// Error when unable to save onboarding state
@freezed
class OnboardingSaveError extends OnboardingError with _$OnboardingSaveError {
  const factory OnboardingSaveError({
    required String message,
    String? details,
  }) = _OnboardingSaveError;
}

/// Error when unable to load onboarding state
@freezed
class OnboardingLoadError extends OnboardingError with _$OnboardingLoadError {
  const factory OnboardingLoadError({
    required String message,
    String? details,
  }) = _OnboardingLoadError;
}

/// Error when unable to save interests
@freezed
class InterestsSaveError extends OnboardingError with _$InterestsSaveError {
  const factory InterestsSaveError({
    required String message,
    String? details,
  }) = _InterestsSaveError;
}

/// Validation error
@freezed
class OnboardingValidationError extends OnboardingError
    with _$OnboardingValidationError {
  const factory OnboardingValidationError({
    required String message,
    String? field,
  }) = _OnboardingValidationError;
}

/// Extension to convert error to string
extension OnboardingErrorExtension on OnboardingError {
  String get displayMessage {
    if (this is OnboardingSaveError) {
      final error = this as OnboardingSaveError;
      return 'Unable to save state: ${error.message}';
    } else if (this is OnboardingLoadError) {
      final error = this as OnboardingLoadError;
      return 'Unable to load state: ${error.message}';
    } else if (this is InterestsSaveError) {
      final error = this as InterestsSaveError;
      return 'Unable to save preferences: ${error.message}';
    } else if (this is OnboardingValidationError) {
      final error = this as OnboardingValidationError;
      return 'Authentication error: ${error.message}';
    }
    return 'Unknown error';
  }
}
