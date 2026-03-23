import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/molecules/app_form_field.dart';
import 'package:flutter_starter_kit/shared/design_system/organisms/app_form.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/text_styles.dart';
import 'package:flutter_starter_kit/core/utils/validators.dart';

/// Register Form
/// Specialized form for user registration with terms and conditions
class RegisterForm extends StatefulWidget {
  final Future<void> Function(Map<String, dynamic>)? onSubmit;
  final VoidCallback? onSignIn;
  final bool isLoading;
  final String? errorMessage;

  const RegisterForm({
    super.key,
    this.onSubmit,
    this.onSignIn,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateConfirmPassword(String? value) {
    return Validators.validateConfirmPassword(value,
        password: _passwordController.text);
  }

  Future<void> _handleSubmit(Map<String, String> data) async {
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms and Privacy Policy'),
          backgroundColor: AppColors.errorColor,
        ),
      );
      return;
    }

    if (widget.onSubmit != null) {
      await widget.onSubmit!(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Error message
        if (widget.errorMessage != null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.errorColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppColors.errorColor.withValues(alpha: 0.3)),
            ),
            child: AppText(
              widget.errorMessage!,
              color: AppColors.errorColor,
              textAlign: TextAlign.center,
            ),
          ),
        ],

        // Form
        AppForm(
          submitButtonText: 'Sign up',
          onSubmit: _handleSubmit,
          extraWidgets: [
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreeToTerms = value ?? false;
                    });
                  },
                  activeColor: AppColors.primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.secondary(fontSize: 14),
                        children: [
                          const TextSpan(text: "I've read and agree with the "),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: AppTextStyles.secondary(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const TextSpan(text: ' and the '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AppTextStyles.secondary(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          children: [
            AppNameField(
              label: 'Name',
              controller: _nameController,
            ),
            AppEmailField(
              label: 'Email Address',
              controller: _emailController,
            ),
            AppPasswordField(
              label: 'Password',
              controller: _passwordController,
              hintText: 'Create a password',
            ),
            AppConfirmPasswordField(
              controller: _confirmPasswordController,
              validator: _validateConfirmPassword,
            ),
          ],
        ),
      ],
    );
  }
}
