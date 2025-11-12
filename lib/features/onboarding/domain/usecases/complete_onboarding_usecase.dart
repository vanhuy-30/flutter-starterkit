import 'package:flutter_starter_kit/features/onboarding/domain/repositories/onboarding_repository.dart';

class CompleteOnboardingUseCase {
  final OnboardingRepository _repository;

  CompleteOnboardingUseCase(this._repository);

  Future<void> execute() async {
    await _repository.setOnboardingCompleted(true);
  }
}
