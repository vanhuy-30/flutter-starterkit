import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/routes/route_paths.dart';
import 'package:flutter_starter_kit/core/utils/extensions.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/register_request.dart';
import 'package:flutter_starter_kit/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_starter_kit/features/auth/presentation/widgets/register_form.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/text_styles.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    // Listen to auth state changes
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.isAuthenticated && (previous?.isAuthenticated != true)) {
        // User successfully registered, navigate to home
        context.go(Routes.home);
      }
    });
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const AppIcon(icon: Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                AppText(
                  'Sign up',
                  style: AppTextStyles.bold(
                    color: AppColors.textPrimaryColor,
                    fontSize: context.responsiveFontSize(24),
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8),
                // Subtitle
                AppText(
                  'Create an account to get started',
                  style: AppTextStyles.secondary(
                    color: AppColors.textSecondaryColor,
                    fontSize: context.responsiveFontSize(14),
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 16),
                // Register Form
                RegisterForm(
                  onSubmit: (data) async {
                    final request = RegisterRequest(
                      name: data['name'] ?? '',
                      email: data['email'] ?? '',
                      password: data['password'] ?? '',
                      confirmPassword: data['confirmPassword'] ?? '',
                    );
                    await ref
                        .read(authNotifierProvider.notifier)
                        .register(request);
                  },
                  isLoading: authState.isLoading,
                  errorMessage: authState.error,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
