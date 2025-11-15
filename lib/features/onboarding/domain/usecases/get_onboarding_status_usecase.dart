import 'package:flutter_starter_kit/features/onboarding/domain/repositories/onboarding_repository.dart';

class GetOnboardingStatusUseCase {
  final OnboardingRepository _repository;

  GetOnboardingStatusUseCase(this._repository);

  Future<bool> execute() async {
    return _repository.isOnboardingCompleted();
  }
}
