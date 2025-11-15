import 'package:flutter_starter_kit/features/onboarding/domain/repositories/onboarding_repository.dart';

class SaveInterestsUseCase {
  final OnboardingRepository _repository;

  SaveInterestsUseCase(this._repository);

  Future<void> execute(Set<String> interests) async {
    await _repository.saveSelectedInterests(interests);
  }
}
