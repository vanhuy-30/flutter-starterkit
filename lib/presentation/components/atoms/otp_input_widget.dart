import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPInputWidget extends StatelessWidget {
  final int length;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool autoFocus;
  final double fieldHeight;
  final double fieldWidth;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? defaultBorderColor;
  final BorderRadiusGeometry? borderRadius;

  const OTPInputWidget({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.autoFocus = true,
    this.fieldHeight = 56,
    this.fieldWidth = 56,
    this.textStyle,
    this.backgroundColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.defaultBorderColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      height: fieldHeight,
      width: fieldWidth,
      textStyle: textStyle ??
          const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey.shade200,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        border: Border.all(color: defaultBorderColor ?? Colors.grey.shade400),
      ),
    );

    return Pinput(
      length: length,
      onCompleted: onCompleted,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      autofocus: autoFocus,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: focusedBorderColor ?? Theme.of(context).primaryColor),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: errorBorderColor ?? Colors.red),
        ),
      ),
      showCursor: true,
    );
  }
}
