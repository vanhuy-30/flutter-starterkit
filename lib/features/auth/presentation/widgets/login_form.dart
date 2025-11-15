import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/buttons/app_text_button.dart';
import 'package:flutter_starter_kit/shared/design_system/molecules/app_form_field.dart';
import 'package:flutter_starter_kit/shared/design_system/organisms/app_form.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/features/auth/presentation/widgets/social_login_widget.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/text_styles.dart';

/// Login Form
/// Specialized form for authentication with social login options
class LoginForm extends StatefulWidget {
  final Future<void> Function(Map<String, dynamic>)? onSubmit;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onSignUp;
  final VoidCallback? onSignIn;
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onFacebookSignIn;
  final VoidCallback? onAppleSignIn;
  final bool isLoading;
  final String? errorMessage;
  final bool showSocialLogin;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  const LoginForm({
    super.key,
    this.onSubmit,
    this.onForgotPassword,
    this.onSignUp,
    this.onSignIn,
    this.onGoogleSignIn,
    this.onFacebookSignIn,
    this.onAppleSignIn,
    this.isLoading = false,
    this.errorMessage,
    this.showSocialLogin = true,
    this.emailController,
    this.passwordController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late AppFormController _formController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _formController = AppFormController();
    _emailController = widget.emailController ?? TextEditingController();
    _passwordController = widget.passwordController ?? TextEditingController();

    // Add controllers to form controller
    _formController.addController('email', _emailController);
    _formController.addController('password', _passwordController);
  }

  @override
  void dispose() {
    // Only dispose if we created the controllers
    if (widget.emailController == null) {
      _emailController.dispose();
    }
    if (widget.passwordController == null) {
      _passwordController.dispose();
    }
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Form
        AppForm(
          controller: _formController,
          submitButtonText: 'Login',
          onSubmit: widget.onSubmit,
          globalError: widget.errorMessage,
          extraWidgets: [
            AppTextButton(
              label: 'Forgot password?',
              textColor: AppColors.primaryColor,
              onPressed: widget.onForgotPassword ?? () {},
            ),
          ],
          children: [
            AppEmailField(
              label: 'Email',
              controller: _emailController,
            ),
            AppPasswordField(
              label: 'Password',
              controller: _passwordController,
            ),
          ],
        ),

        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Not a member? ',
              style: AppTextStyles.secondary(fontSize: 14),
            ),
            TextButton(
              onPressed: widget.onSignUp,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Register now',
                style: AppTextStyles.secondary(
                    fontSize: 14, color: AppColors.primaryColor),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Social login
        if (widget.showSocialLogin) ...[
          SocialLoginWidget(
            onGoogleSignIn: widget.onGoogleSignIn,
            onAppleSignIn: widget.onAppleSignIn,
            onFacebookSignIn: widget.onFacebookSignIn,
            isLoading: widget.isLoading,
          ),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
