import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/models/onboarding_state.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/errors/onboarding_errors.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/save_interests_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/view_model/onboarding_notifier.dart';

// Mock classes
class MockGetOnboardingStatusUseCase implements GetOnboardingStatusUseCase {
  bool _shouldThrowError = false;
  bool _returnValue = false;

  set shouldThrowError(bool shouldThrow) {
    _shouldThrowError = shouldThrow;
  }

  set returnValue(bool value) {
    _returnValue = value;
  }

  @override
  Future<bool> execute() async {
    if (_shouldThrowError) {
      throw const OnboardingLoadError(message: 'Test error');
    }
    return _returnValue;
  }
}

class MockCompleteOnboardingUseCase implements CompleteOnboardingUseCase {
  bool _shouldThrowError = false;

  set shouldThrowError(bool shouldThrow) {
    _shouldThrowError = shouldThrow;
  }

  @override
  Future<void> execute() async {
    if (_shouldThrowError) {
      throw const OnboardingSaveError(message: 'Test error');
    }
  }
}

class MockSaveInterestsUseCase implements SaveInterestsUseCase {
  bool _shouldThrowError = false;

  set shouldThrowError(bool shouldThrow) {
    _shouldThrowError = shouldThrow;
  }

  @override
  Future<void> execute(Set<String> interests) async {
    if (_shouldThrowError) {
      throw const InterestsSaveError(message: 'Test error');
    }
  }
}

void main() {
  group('OnboardingNotifier', () {
    late MockGetOnboardingStatusUseCase mockGetStatusUseCase;
    late MockCompleteOnboardingUseCase mockCompleteUseCase;
    late MockSaveInterestsUseCase mockSaveInterestsUseCase;
    late OnboardingNotifier notifier;

    setUp(() {
      mockGetStatusUseCase = MockGetOnboardingStatusUseCase();
      mockCompleteUseCase = MockCompleteOnboardingUseCase();
      mockSaveInterestsUseCase = MockSaveInterestsUseCase();
      notifier = OnboardingNotifier(
        mockGetStatusUseCase,
        mockCompleteUseCase,
        mockSaveInterestsUseCase,
      );
    });

    test('should initialize with default state', () {
      expect(notifier.state, const OnboardingState());
    });

    group('initialize', () {
      test('should set loading to true then false on success', () async {
        mockGetStatusUseCase.returnValue = true;

        await notifier.initialize();

        expect(notifier.state.isLoading, true);
        expect(notifier.state.isCompleted, false);

        await Future.delayed(Duration.zero);

        expect(notifier.state.isLoading, false);
        expect(notifier.state.isCompleted, true);
        expect(notifier.state.error, null);
      });

      test('should handle error during initialization', () async {
        mockGetStatusUseCase.shouldThrowError = true;

        await notifier.initialize();

        expect(notifier.state.isLoading, true);

        await Future.delayed(Duration.zero);

        expect(notifier.state.isLoading, false);
        expect(notifier.state.error, isA<OnboardingLoadError>());
      });
    });

    group('toggleInterest', () {
      test('should add interest when not selected', () {
        const interest = 'Test Interest';

        notifier.toggleInterest(interest);

        expect(notifier.state.selectedInterests, contains(interest));
      });

      test('should remove interest when already selected', () {
        const interest = 'Test Interest';

        notifier.toggleInterest(interest);
        notifier.toggleInterest(interest);

        expect(notifier.state.selectedInterests, isNot(contains(interest)));
      });
    });

    group('toggleGoal', () {
      test('should add goal when not selected', () {
        const goal = 'Test Goal';

        notifier.toggleGoal(goal);

        expect(notifier.state.selectedGoals, contains(goal));
      });

      test('should remove goal when already selected', () {
        const goal = 'Test Goal';

        notifier.toggleGoal(goal);
        notifier.toggleGoal(goal);

        expect(notifier.state.selectedGoals, isNot(contains(goal)));
      });
    });

    group('completeOnboarding', () {
      test('should complete onboarding successfully', () async {
        notifier.toggleInterest('Test Interest');
        notifier.toggleGoal('Test Goal');

        await notifier.completeOnboarding();

        expect(notifier.state.isCompleting, true);

        await Future.delayed(Duration.zero);

        expect(notifier.state.isCompleting, false);
        expect(notifier.state.isCompleted, true);
        expect(notifier.state.error, null);
      });

      test('should handle error during completion', () async {
        mockCompleteUseCase.shouldThrowError = true;

        await notifier.completeOnboarding();

        expect(notifier.state.isCompleting, true);

        await Future.delayed(Duration.zero);

        expect(notifier.state.isCompleting, false);
        expect(notifier.state.error, isA<OnboardingSaveError>());
      });

      test('should handle error when saving interests', () async {
        notifier.toggleInterest('Test Interest');
        mockSaveInterestsUseCase.shouldThrowError = true;

        await notifier.completeOnboarding();

        await Future.delayed(Duration.zero);

        expect(notifier.state.error, isA<InterestsSaveError>());
      });
    });

    group('clearError', () {
      test('should clear error from state', () {
        notifier.state = notifier.state.copyWith(
          error: const OnboardingLoadError(message: 'Test error'),
        );

        notifier.clearError();

        expect(notifier.state.error, null);
      });
    });
  });
}
