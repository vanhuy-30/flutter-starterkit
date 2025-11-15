import 'package:flutter_starter_kit/core/services/preferences_service.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/errors/onboarding_errors.dart';
import 'dart:convert';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final PreferencesService _preferencesService;
  static const String _interestsKey = 'onboarding_interests';
  static const String _goalsKey = 'onboarding_goals';

  OnboardingRepositoryImpl(this._preferencesService);

  @override
  Future<bool> isOnboardingCompleted() async {
    try {
      return _preferencesService.getOnboardingCompleted();
    } catch (e) {
      throw OnboardingLoadError(
        message: 'Không thể tải trạng thái onboarding',
        details: e.toString(),
      );
    }
  }

  @override
  Future<void> setOnboardingCompleted(bool completed) async {
    try {
      await _preferencesService.setOnboardingCompleted(completed);
    } catch (e) {
      throw OnboardingSaveError(
        message: 'Không thể lưu trạng thái onboarding',
        details: e.toString(),
      );
    }
  }

  @override
  Future<List<String>> getAvailableInterests() async {
    // Return static list of interests
    // Can load from API or config in the future
    return [
      'User Interface',
      'User Experience',
      'User Research',
      'UX Writing',
      'User Testing',
      'Service Design',
      'Strategy',
      'Design Systems',
    ];
  }

  @override
  Future<void> saveSelectedInterests(Set<String> interests) async {
    try {
      // Save interests to SharedPreferences in JSON format
      final interestsList = interests.toList();
      final interestsJson = jsonEncode(interestsList);
      await _preferencesService.setString(_interestsKey, interestsJson);
    } catch (e) {
      throw InterestsSaveError(
        message: 'Không thể lưu sở thích',
        details: e.toString(),
      );
    }
  }

  /// Save goals
  Future<void> saveSelectedGoals(Set<String> goals) async {
    try {
      final goalsList = goals.toList();
      final goalsJson = jsonEncode(goalsList);
      await _preferencesService.setString(_goalsKey, goalsJson);
    } catch (e) {
      throw InterestsSaveError(
        message: 'Không thể lưu mục tiêu',
        details: e.toString(),
      );
    }
  }

  /// Get saved interests
  Future<Set<String>> getSavedInterests() async {
    try {
      final interestsJson = _preferencesService.getString(_interestsKey);
      if (interestsJson != null) {
        final interestsList = List<String>.from(jsonDecode(interestsJson));
        return interestsList.toSet();
      }
      return <String>{};
    } catch (e) {
      throw OnboardingLoadError(
        message: 'Không thể tải sở thích đã lưu',
        details: e.toString(),
      );
    }
  }

  /// Get saved goals
  Future<Set<String>> getSavedGoals() async {
    try {
      final goalsJson = _preferencesService.getString(_goalsKey);
      if (goalsJson != null) {
        final goalsList = List<String>.from(jsonDecode(goalsJson));
        return goalsList.toSet();
      }
      return <String>{};
    } catch (e) {
      throw OnboardingLoadError(
        message: 'Không thể tải mục tiêu đã lưu',
        details: e.toString(),
      );
    }
  }
}
