abstract class OnboardingRepository {
  Future<bool> isOnboardingCompleted();
  Future<void> setOnboardingCompleted(bool completed);
  Future<List<String>> getAvailableInterests();
  Future<void> saveSelectedInterests(Set<String> interests);
}
