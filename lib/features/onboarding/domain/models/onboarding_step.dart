enum OnboardingStepType {
  welcome,
  personalize,
}

class OnboardingStep {
  final OnboardingStepType type;
  final String title;
  final String description;
  final bool isLastStep;

  const OnboardingStep({
    required this.type,
    required this.title,
    required this.description,
    this.isLastStep = false,
  });
}
