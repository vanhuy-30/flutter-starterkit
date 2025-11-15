import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/text_styles.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/buttons/app_button.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/providers/onboarding_providers.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/widgets/onboarding_progress_widgets.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/widgets/interest_selection_card.dart';

class OnboardingStep2 extends ConsumerStatefulWidget {
  final VoidCallback onComplete;

  const OnboardingStep2({
    super.key,
    required this.onComplete,
  });

  @override
  ConsumerState<OnboardingStep2> createState() => _OnboardingStep2State();
}

class _OnboardingStep2State extends ConsumerState<OnboardingStep2> {
  final List<String> _goals = [
    'Learn New Skills',
    'Career Growth',
    'Personal Development',
    'Stay Updated',
    'Networking',
    'Creative Expression',
    'Problem Solving',
    'Innovation',
  ];
  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingNotifierProvider);
    final notifier = ref.read(onboardingNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              OnboardingProgressIndicator(
                currentStepCompleted:
                    onboardingState.selectedGoals.isNotEmpty ? 2 : 1,
                totalSteps: 2,
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                'What\'s your goal?',
                style: AppTextStyles.bold(
                  fontSize: 24,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                'Choose your primary goal.',
                style: AppTextStyles.normal(
                  color: AppColors.textSecondaryColor,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              // Goal selection list
              Expanded(
                child: ListView.builder(
                  itemCount: _goals.length,
                  itemBuilder: (context, index) {
                    final goal = _goals[index];
                    final isSelected =
                        onboardingState.selectedGoals.contains(goal);

                    return InterestSelectionCard(
                      title: goal,
                      isSelected: isSelected,
                      onTap: () {
                        notifier.toggleGoal(goal);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              // Get Started button
              AppButton(
                text: 'Get Started',
                isDisabled: onboardingState.selectedGoals.isEmpty,
                color: Colors.blue,
                onPressed: () {
                  notifier.completeOnboarding().then((_) {
                    if (mounted) {
                      widget.onComplete();
                    }
                  });
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
