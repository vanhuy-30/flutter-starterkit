import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/errors/onboarding_errors.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/providers/onboarding_providers.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/pages/welcome_page.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/widgets/onboarding_step1.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/widgets/onboarding_step2.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  final VoidCallback onComplete;

  const OnboardingPage({
    super.key,
    required this.onComplete,
  });

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    // Initialize onboarding state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingNotifierProvider.notifier).initialize();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _completeOnboarding() {
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final onboardingState = ref.watch(onboardingNotifierProvider);

        // Show error snackbar if there is an error
        if (onboardingState.error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(onboardingState.error!.displayMessage),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Đóng',
                  textColor: Colors.white,
                  onPressed: () {
                    ref.read(onboardingNotifierProvider.notifier).clearError();
                  },
                ),
              ),
            );
          });
        }

        return Scaffold(
          body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              WelcomePage(
                onNext: _nextStep,
              ),
              OnboardingStep1(
                onNext: _nextStep,
              ),
              OnboardingStep2(
                onComplete: _completeOnboarding,
              ),
            ],
          ),
        );
      },
    );
  }
}
