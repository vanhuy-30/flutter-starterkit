import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';
import 'package:flutter_starter_kit/core/theme/sizes.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String? lableText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function()? onSuffixIconTap;
  final TextInputAction? textInputAction;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final Color? cursorColor;
  final Color? fillColor;
  final double? width;
  final double? height;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool? enabled;
  final InputDecoration? decoration;
  final TextStyle? style;
  final String? errorText;

  const AppTextField({
    super.key,
    required this.hintText,
    this.lableText,
    this.prefixIcon,
    this.suffixIcon,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSuffixIconTap,
    this.textInputAction,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.cursorColor,
    this.fillColor,
    this.width,
    this.height,
    this.focusNode,
    this.autofocus = false,
    this.enabled,
    this.decoration,
    this.style,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: style,
        validator: validator,
        autofocus: autofocus,
        focusNode: focusNode,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        cursorColor: cursorColor ?? AppColors.primaryColor,
        decoration: decoration ?? InputDecoration(
          hintText: hintText,
          labelText: lableText,
          errorText: errorText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: fillColor ?? AppColors.backgroundColor,
          border: const OutlineInputBorder(
            borderRadius: AppSizes.borderRadiusMedium,
            borderSide: BorderSide(color: AppColors.greyColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: AppSizes.borderRadiusMedium,
            borderSide: BorderSide(
              color: AppColors.greyColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: AppSizes.borderRadiusMedium,
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2.0,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}
