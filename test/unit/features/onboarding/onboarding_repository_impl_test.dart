import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/core/services/preferences_service.dart';
import 'package:flutter_starter_kit/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/errors/onboarding_errors.dart';

class MockPreferencesService implements PreferencesService {
  bool _onboardingCompleted = false;
  String? _interestsJson;
  String? _goalsJson;
  bool _shouldThrowError = false;

  set setOnboardingCompletedValue(bool value) {
    _onboardingCompleted = value;
  }

  set setInterestsJson(String? json) {
    _interestsJson = json;
  }

  set setGoalsJson(String? json) {
    _goalsJson = json;
  }

  set setShouldThrowError(bool shouldThrow) {
    _shouldThrowError = shouldThrow;
  }

  @override
  Future<void> init() async {}

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    if (_shouldThrowError) throw Exception('Test error');
  }

  @override
  bool getDarkMode() => false;

  @override
  Future<void> setLocale(dynamic locale) async {
    if (_shouldThrowError) throw Exception('Test error');
  }

  @override
  Locale? getLocale() => null;

  @override
  Future<void> setOnboardingCompleted(bool isCompleted) async {
    if (_shouldThrowError) throw Exception('Test error');
    _onboardingCompleted = isCompleted;
  }

  @override
  bool getOnboardingCompleted() {
    if (_shouldThrowError) throw Exception('Test error');
    return _onboardingCompleted;
  }

  @override
  Future<void> setString(String key, String value) async {
    if (_shouldThrowError) throw Exception('Test error');
    if (key == 'onboarding_interests') {
      _interestsJson = value;
    } else if (key == 'onboarding_goals') {
      _goalsJson = value;
    }
  }

  @override
  String? getString(String key) {
    if (_shouldThrowError) throw Exception('Test error');
    if (key == 'onboarding_interests') {
      return _interestsJson;
    } else if (key == 'onboarding_goals') {
      return _goalsJson;
    }
    return null;
  }
}

void main() {
  group('OnboardingRepositoryImpl', () {
    late MockPreferencesService mockPreferencesService;
    late OnboardingRepositoryImpl repository;

    setUp(() {
      mockPreferencesService = MockPreferencesService();
      repository = OnboardingRepositoryImpl(mockPreferencesService);
    });

    group('isOnboardingCompleted', () {
      test('should return true when onboarding is completed', () async {
        mockPreferencesService.setOnboardingCompletedValue = true;

        final result = await repository.isOnboardingCompleted();

        expect(result, true);
      });

      test('should return false when onboarding is not completed', () async {
        mockPreferencesService.setOnboardingCompletedValue = false;

        final result = await repository.isOnboardingCompleted();

        expect(result, false);
      });

      test('should throw OnboardingLoadError when preferences service throws',
          () async {
        mockPreferencesService.setShouldThrowError = true;

        expect(
          () => repository.isOnboardingCompleted(),
          throwsA(isA<OnboardingLoadError>()),
        );
      });
    });

    group('setOnboardingCompleted', () {
      test('should set onboarding completed successfully', () async {
        await repository.setOnboardingCompleted(true);

        expect(mockPreferencesService.getOnboardingCompleted(), true);
      });

      test('should throw OnboardingSaveError when preferences service throws',
          () async {
        mockPreferencesService.setShouldThrowError = true;

        expect(
          () => repository.setOnboardingCompleted(true),
          throwsA(isA<OnboardingSaveError>()),
        );
      });
    });

    group('getAvailableInterests', () {
      test('should return list of available interests', () async {
        final interests = await repository.getAvailableInterests();

        expect(interests, isA<List<String>>());
        expect(interests.length, greaterThan(0));
        expect(interests, contains('User Interface'));
        expect(interests, contains('User Experience'));
      });
    });

    group('saveSelectedInterests', () {
      test('should save interests successfully', () async {
        final interests = {'User Interface', 'User Experience'};

        await repository.saveSelectedInterests(interests);

        expect(mockPreferencesService.getString('onboarding_interests'),
            isNotNull);
      });

      test('should throw InterestsSaveError when preferences service throws',
          () async {
        mockPreferencesService.setShouldThrowError = true;
        final interests = {'User Interface'};

        expect(
          () => repository.saveSelectedInterests(interests),
          throwsA(isA<InterestsSaveError>()),
        );
      });
    });

    group('saveSelectedGoals', () {
      test('should save goals successfully', () async {
        final goals = {'Learn New Skills', 'Career Growth'};

        await repository.saveSelectedGoals(goals);

        expect(mockPreferencesService.getString('onboarding_goals'), isNotNull);
      });

      test('should throw InterestsSaveError when preferences service throws',
          () async {
        mockPreferencesService.setShouldThrowError = true;
        final goals = {'Learn New Skills'};

        expect(
          () => repository.saveSelectedGoals(goals),
          throwsA(isA<InterestsSaveError>()),
        );
      });
    });

    group('getSavedInterests', () {
      test('should return empty set when no interests saved', () async {
        final interests = await repository.getSavedInterests();

        expect(interests, isEmpty);
      });

      test('should return saved interests', () async {
        final expectedInterests = {'User Interface', 'User Experience'};
        mockPreferencesService.setInterestsJson =
            '["User Interface","User Experience"]';

        final interests = await repository.getSavedInterests();

        expect(interests, expectedInterests);
      });

      test('should throw OnboardingLoadError when preferences service throws',
          () async {
        mockPreferencesService.setShouldThrowError = true;

        expect(
          () => repository.getSavedInterests(),
          throwsA(isA<OnboardingLoadError>()),
        );
      });
    });

    group('getSavedGoals', () {
      test('should return empty set when no goals saved', () async {
        final goals = await repository.getSavedGoals();

        expect(goals, isEmpty);
      });

      test('should return saved goals', () async {
        final expectedGoals = {'Learn New Skills', 'Career Growth'};
        mockPreferencesService.setGoalsJson =
            '["Learn New Skills","Career Growth"]';

        final goals = await repository.getSavedGoals();

        expect(goals, expectedGoals);
      });

      test('should throw OnboardingLoadError when preferences service throws',
          () async {
        mockPreferencesService.setShouldThrowError = true;

        expect(
          () => repository.getSavedGoals(),
          throwsA(isA<OnboardingLoadError>()),
        );
      });
    });
  });
}
