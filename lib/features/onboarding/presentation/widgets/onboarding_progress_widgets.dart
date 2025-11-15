import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/text_styles.dart';

class OnboardingProgressIndicator extends StatefulWidget {
  final int currentStepCompleted;
  final int totalSteps;

  const OnboardingProgressIndicator({
    super.key,
    required this.currentStepCompleted,
    required this.totalSteps,
  });

  @override
  State<OnboardingProgressIndicator> createState() =>
      _OnboardingProgressIndicatorState();
}

class _OnboardingProgressIndicatorState
    extends State<OnboardingProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    final calculatedProgress = widget.currentStepCompleted / widget.totalSteps;
    _progressAnimation = Tween<double>(
      begin: 0,
      end: calculatedProgress,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void didUpdateWidget(OnboardingProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStepCompleted != widget.currentStepCompleted ||
        oldWidget.totalSteps != widget.totalSteps) {
      final calculatedProgress =
          widget.currentStepCompleted / widget.totalSteps;
      _progressAnimation = Tween<double>(
        begin: _progressAnimation.value,
        end: calculatedProgress,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));

      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(3),
            ),
            child: AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progressAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.currentStepCompleted >= widget.totalSteps
                          ? Colors.blue
                          : Colors.blue.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
            '${widget.currentStepCompleted}/${widget.totalSteps} step completed',
            style: AppTextStyles.normal()),
      ],
    );
  }
}
