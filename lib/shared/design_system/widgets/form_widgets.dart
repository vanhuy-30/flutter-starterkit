import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// Form-specific widgets for better performance

/// Form field wrapper
class AppFormFieldWrapper extends StatelessWidget {
  final String label;
  final Widget child;
  final String? errorText;
  final bool isRequired;
  final String? helperText;

  const AppFormFieldWrapper({
    super.key,
    required this.label,
    required this.child,
    this.errorText,
    this.isRequired = false,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppAutoSizeText(
              label,
              maxFontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimaryColor,
            ),
            if (isRequired) ...[
              const SizedBox(width: 4),
              const AppAutoSizeText(
                '*',
                color: AppColors.errorColor,
                maxFontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        child,
        if (helperText != null) ...[
          const SizedBox(height: 4),
          AppAutoSizeText(
            helperText!,
            maxFontSize: 12,
            color: AppColors.textSecondaryColor,
          ),
        ],
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const AppIcon(
                icon: AppIcons.errorOutlined,
                size: 16,
                color: AppColors.errorColor,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: AppAutoSizeText(
                  errorText!,
                  maxFontSize: 12,
                  color: AppColors.errorColor,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Social login button
class AppSocialLoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const AppSocialLoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.white,
          foregroundColor: textColor ?? AppColors.textPrimaryColor,
          side: const BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIcon(
              icon: icon,
              size: 20,
              color: textColor ?? AppColors.textPrimaryColor,
            ),
            const SizedBox(width: 12),
            AppText(
              text,
              color: textColor ?? AppColors.textPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}

/// Form action buttons
class AppFormActions extends StatelessWidget {
  final String submitText;
  final String? cancelText;
  final VoidCallback onSubmit;
  final VoidCallback? onCancel;
  final bool isLoading;
  final bool showCancelButton;

  const AppFormActions({
    super.key,
    required this.submitText,
    required this.onSubmit,
    this.cancelText,
    this.onCancel,
    this.isLoading = false,
    this.showCancelButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showCancelButton) ...[
          Expanded(
            child: OutlinedButton(
              onPressed: isLoading ? null : onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textSecondaryColor,
                side: const BorderSide(color: AppColors.borderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: AppText(
                cancelText ?? 'Cancel',
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
        Expanded(
          child: ElevatedButton(
            onPressed: isLoading ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : AppText(
                    submitText,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
          ),
        ),
      ],
    );
  }
}
