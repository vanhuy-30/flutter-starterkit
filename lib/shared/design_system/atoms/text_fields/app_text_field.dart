import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// App Text Field
/// A customizable text field widget with consistent styling
class AppTextField extends StatelessWidget {
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

  const AppTextField({
    super.key,
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onTap: onTap,
        readOnly: readOnly,
        enabled: enabled,
        maxLines: maxLines,
        minLines: minLines,
        focusNode: focusNode,
        autofocus: autofocus,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        style: TextStyle(
          color: enabled
              ? (isDark
                  ? AppColors.darkThemeTextColor
                  : AppColors.lightThemeTextColor)
              : AppColors.textSecondaryColor,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.textSecondaryColor,
            fontSize: 16,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
                  onTap: onSuffixIconTap,
                  child: suffixIcon,
                )
              : null,
          filled: true,
          fillColor:
              fillColor ?? (isDark ? AppColors.darkSurface : Colors.white),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: border ?? _getDefaultBorder(isDark),
          enabledBorder: enabledBorder ?? _getDefaultEnabledBorder(isDark),
          focusedBorder: focusedBorder ?? _getDefaultFocusedBorder(isDark),
          errorBorder: errorBorder ?? _getDefaultErrorBorder(isDark),
          focusedErrorBorder:
              focusedErrorBorder ?? _getDefaultFocusedErrorBorder(isDark),
          disabledBorder: disabledBorder ?? _getDefaultDisabledBorder(isDark),
          errorText: errorText,
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
