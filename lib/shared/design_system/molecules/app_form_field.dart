import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/text_fields/app_text_field.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/core/utils/validators.dart';

/// App Form Field
/// Wrapper for form fields with optional label, validation, and error handling
class AppFormField extends StatelessWidget {
  final String? label;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onSuffixIconTap;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final String? helperText;
  final String? errorText;
  final Color? fillColor;
  final double? width;
  final double? height;
  final FocusNode? focusNode;
  final bool autofocus;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;

  const AppFormField({
    super.key,
    this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onSuffixIconTap,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.helperText,
    this.errorText,
    this.fillColor,
    this.width,
    this.height,
    this.focusNode,
    this.autofocus = false,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show label only if provided
        if (label != null) ...[
          AppText(
            label!,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimaryColor,
          ),
          const SizedBox(height: 8),
        ],

        AppTextField(
          hintText: hintText,
          controller: controller,
          validator: validator,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onSuffixIconTap: onSuffixIconTap,
          onTap: onTap,
          readOnly: readOnly,
          enabled: enabled,
          maxLines: maxLines,
          minLines: minLines,
          errorText: errorText,
          fillColor: fillColor,
          width: width,
          height: height,
          focusNode: focusNode,
          autofocus: autofocus,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
        ),

        if (helperText != null || errorText != null) ...[
          const SizedBox(height: 4),
          AppText(
            errorText ?? helperText!,
            color: errorText != null
                ? AppColors.errorColor
                : AppColors.textSecondaryColor,
            maxLines: 2,
          ),
        ],
      ],
    );
  }
}

/// Specialized form field for email input
class AppEmailField extends StatelessWidget {
  final String? label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? helperText;
  final String? errorText;

  const AppEmailField({
    super.key,
    this.label,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.helperText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      label: label,
      hintText: 'enter_email'.tr(),
      controller: controller,
      validator: validator ?? Validators.validateEmail,
      prefixIcon: const AppIcon(
        icon: AppIcons.emailOutlined,
        color: AppColors.primaryColor,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      enabled: enabled,
      helperText: helperText,
      errorText: errorText,
    );
  }
}

/// Specialized form field for password input
class AppPasswordField extends StatefulWidget {
  final String? label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? helperText;
  final String? errorText;
  final String? hintText;

  const AppPasswordField({
    super.key,
    this.label,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.helperText,
    this.errorText,
    this.hintText,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      label: widget.label,
      hintText: widget.hintText ?? 'enter_password'.tr(),
      controller: widget.controller,
      validator: widget.validator ?? Validators.validatePassword,
      prefixIcon: const AppIcon(
        icon: AppIcons.lockOutlined,
        color: AppColors.primaryColor,
      ),
      suffixIcon: IconButton(
        icon: AppIcon(
          icon: _obscureText ? AppIcons.visibilityOff : AppIcons.visibility,
          color: AppColors.textSecondaryColor,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
      obscureText: _obscureText,
      textInputAction: TextInputAction.done,
      enabled: widget.enabled,
      helperText: widget.helperText,
      errorText: widget.errorText,
    );
  }
}

/// Specialized form field for phone number input
class AppPhoneField extends StatelessWidget {
  final String? label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? helperText;
  final String? errorText;

  const AppPhoneField({
    super.key,
    this.label,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.helperText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      label: label,
      hintText: 'enter_phone'.tr(),
      controller: controller,
      validator: validator ?? Validators.validatePhone,
      prefixIcon: const AppIcon(
        icon: AppIcons.phoneOutlined,
        color: AppColors.primaryColor,
      ),
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      enabled: enabled,
      helperText: helperText,
      errorText: errorText,
    );
  }
}

/// Specialized form field for name input
class AppNameField extends StatelessWidget {
  final String? label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? helperText;
  final String? errorText;

  const AppNameField({
    super.key,
    this.label,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.helperText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      label: label,
      hintText: 'Enter your name',
      controller: controller,
      validator: validator ?? Validators.validateName,
      prefixIcon: const AppIcon(
        icon: AppIcons.profileOutlined,
        color: AppColors.primaryColor,
      ),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      enabled: enabled,
      helperText: helperText,
      errorText: errorText,
    );
  }
}

/// Specialized form field for confirm password input
class AppConfirmPasswordField extends StatefulWidget {
  final String? label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? helperText;
  final String? errorText;
  final String? hintText;

  const AppConfirmPasswordField({
    super.key,
    this.label,
    required this.controller,
    this.validator,
    this.enabled = true,
    this.helperText,
    this.errorText,
    this.hintText,
  });

  @override
  State<AppConfirmPasswordField> createState() =>
      _AppConfirmPasswordFieldState();
}

class _AppConfirmPasswordFieldState extends State<AppConfirmPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      label: widget.label,
      hintText: widget.hintText ?? 'Confirm password',
      controller: widget.controller,
      validator: widget.validator ?? Validators.validateConfirmPassword,
      prefixIcon: const AppIcon(
        icon: AppIcons.lockOutlined,
        color: AppColors.primaryColor,
      ),
      suffixIcon: IconButton(
        icon: AppIcon(
          icon: _obscureText ? AppIcons.visibilityOff : AppIcons.visibility,
          color: AppColors.textSecondaryColor,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
      obscureText: _obscureText,
      textInputAction: TextInputAction.done,
      enabled: widget.enabled,
      helperText: widget.helperText,
      errorText: widget.errorText,
    );
  }
}

/// Specialized form field for search input
class AppSearchField extends StatefulWidget {
  final String? label;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onSearch;
  final VoidCallback? onClear;
  final void Function(String)? onChanged;
  final bool enabled;
  final String? errorText;

  const AppSearchField({
    super.key,
    this.label,
    this.hintText = 'Search...',
    required this.controller,
    this.onSearch,
    this.onClear,
    this.onChanged,
    this.enabled = true,
    this.errorText,
  });

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  @override
  Widget build(BuildContext context) {
    return AppFormField(
      label: widget.label,
      hintText: widget.hintText,
      controller: widget.controller,
      prefixIcon: const AppIcon(
        icon: AppIcons.search,
        color: AppColors.primaryColor,
      ),
      suffixIcon: widget.controller.text.isNotEmpty
          ? IconButton(
              icon: const AppIcon(
                icon: AppIcons.clear,
                color: AppColors.textSecondaryColor,
              ),
              onPressed: () {
                widget.controller.clear();
                widget.onClear?.call();
                setState(() {}); // Refresh to hide clear button
              },
            )
          : null,
      onChanged: (value) {
        widget.onChanged?.call(value);
        setState(() {}); // Refresh to show/hide clear button
      },
      onFieldSubmitted: (_) => widget.onSearch?.call(),
      enabled: widget.enabled,
      errorText: widget.errorText,
    );
  }
}
