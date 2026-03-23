import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/text_styles.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/buttons/app_button.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/state/onboarding_providers.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/widgets/onboarding_progress_widgets.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/widgets/interest_selection_card.dart';

class OnboardingStep1 extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const OnboardingStep1({
    super.key,
    required this.onNext,
  });

  @override
  ConsumerState<OnboardingStep1> createState() => _OnboardingStep1State();
}

class _OnboardingStep1State extends ConsumerState<OnboardingStep1> {
  final List<String> _interests = [
    'User Interface',
    'User Experience',
    'User Research',
    'UX Writing',
    'User Testing',
    'Service Design',
    'Strategy',
    'Design Systems',
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
                    onboardingState.selectedInterests.isNotEmpty ? 1 : 0,
                totalSteps: 2,
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                'Personalise your experience',
                style: AppTextStyles.bold(
                  fontSize: 24,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 8),
              // Subtitle
              Text(
                'Choose your interests.',
                style: AppTextStyles.normal(
                  color: AppColors.textSecondaryColor,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              // Interest selection list
              Expanded(
                child: ListView.builder(
                  itemCount: _interests.length,
                  itemBuilder: (context, index) {
                    final interest = _interests[index];
                    final isSelected =
                        onboardingState.selectedInterests.contains(interest);

                    return InterestSelectionCard(
                      title: interest,
                      isSelected: isSelected,
                      onTap: () {
                        notifier.toggleInterest(interest);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              // Next button
              AppButton(
                text: 'Next',
                isDisabled: onboardingState.selectedInterests.isEmpty,
                color: Colors.blue,
                onPressed: () {
                  widget.onNext();
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
