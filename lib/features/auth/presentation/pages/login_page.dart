import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/routes/route_paths.dart';
import 'package:flutter_starter_kit/core/utils/extensions.dart';
import 'package:flutter_starter_kit/features/auth/presentation/state/auth_providers.dart';
import 'package:flutter_starter_kit/features/auth/presentation/state/login_notifier.dart';
import 'package:flutter_starter_kit/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter_starter_kit/shared/assets/icons.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/text_styles.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginNotifierProvider);

    // Listen to auth state changes
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.isAuthenticated && (previous?.isAuthenticated != true)) {
        // User successfully logged in, navigate to home
        context.go(Routes.home);
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: context.screenHeight * 0.35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
            ),
            child: const Center(child: AppIcon(icon: imageIcon)),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Title
                      AppText(
                        'Welcome!',
                        style: AppTextStyles.bold(
                          color: AppColors.textPrimaryColor,
                          fontSize: context.responsiveFontSize(24),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10),
                      // Login Form with integrated state management
                      LoginForm(
                        emailController: loginState.usernameController,
                        passwordController: loginState.passwordController,
                        onSubmit: (data) async {
                          await ref
                              .read(loginNotifierProvider.notifier)
                              .login();
                        },
                        onGoogleSignIn: () async {
                          await ref
                              .read(loginNotifierProvider.notifier)
                              .loginWithGoogle();
                        },
                        onAppleSignIn: () async {
                          await ref
                              .read(loginNotifierProvider.notifier)
                              .loginWithApple();
                        },
                        onFacebookSignIn: () async {
                          await ref
                              .read(loginNotifierProvider.notifier)
                              .loginWithFacebook();
                        },
                        onSignUp: () => context.push(Routes.register),
                        isLoading: loginState.isLoading,
                        errorMessage: loginState.error,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
