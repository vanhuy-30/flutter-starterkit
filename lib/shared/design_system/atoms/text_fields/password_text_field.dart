import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/core/utils/validators.dart';

/// Password Text Field Widget
/// A specialized text field for password input with show/hide toggle
class PasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final String? errorText;
  final Color? fillColor;
  final double? width;
  final double? height;
  final FocusNode? focusNode;
  final bool autofocus;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;

  const PasswordTextField({
    super.key,
    this.hintText = 'Nhập mật khẩu',
    required this.controller,
    this.validator,
    this.enabled = true,
    this.errorText,
    this.fillColor,
    this.width,
    this.height,
    this.focusNode,
    this.autofocus = false,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator ?? Validators.validatePassword,
        obscureText: _obscureText,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        enabled: widget.enabled,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onFieldSubmitted,
        style: TextStyle(
          color: widget.enabled
              ? (isDark
                  ? AppColors.darkThemeTextColor
                  : AppColors.lightThemeTextColor)
              : AppColors.textSecondaryColor,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AppColors.textSecondaryColor,
            fontSize: 16,
          ),
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
          filled: true,
          fillColor: widget.fillColor ??
              (isDark ? AppColors.darkSurface : Colors.white),
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: widget.border ?? _getDefaultBorder(isDark),
          enabledBorder:
              widget.enabledBorder ?? _getDefaultEnabledBorder(isDark),
          focusedBorder:
              widget.focusedBorder ?? _getDefaultFocusedBorder(isDark),
          errorBorder: widget.errorBorder ?? _getDefaultErrorBorder(isDark),
          focusedErrorBorder: widget.focusedErrorBorder ??
              _getDefaultFocusedErrorBorder(isDark),
          disabledBorder:
              widget.disabledBorder ?? _getDefaultDisabledBorder(isDark),
          errorText: widget.errorText,
          errorStyle: const TextStyle(
            color: AppColors.errorColor,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  InputBorder _getDefaultBorder(bool isDark) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        width: 1,
      ),
    );
  }

  InputBorder _getDefaultEnabledBorder(bool isDark) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        width: 1,
      ),
    );
  }

  InputBorder _getDefaultFocusedBorder(bool isDark) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.primaryColor,
        width: 2,
      ),
    );
  }

  InputBorder _getDefaultErrorBorder(bool isDark) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.errorColor,
        width: 1,
      ),
    );
  }

  InputBorder _getDefaultFocusedErrorBorder(bool isDark) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.errorColor,
        width: 2,
      ),
    );
  }

  InputBorder _getDefaultDisabledBorder(bool isDark) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: isDark ? AppColors.darkDisabled : AppColors.lightDisabled,
        width: 1,
      ),
    );
  }
}
