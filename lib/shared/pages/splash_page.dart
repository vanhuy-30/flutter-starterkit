import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/shared/assests/images.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/providers/onboarding_providers.dart';
import 'package:flutter_starter_kit/app/routes/route_paths.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      final onboardingState = ref.read(onboardingNotifierProvider);

      if (onboardingState.isCompleted) {
        // Onboarding completed, go to login
        context.go(Routes.login);
      } else {
        // Onboarding not completed, go to onboarding
        context.go(Routes.onboarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(splashLogo, width: 100, height: 100),
      ),
    );
  }
}
