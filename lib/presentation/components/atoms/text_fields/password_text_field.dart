import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/text_fields/app_text_field.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? lableText;
  final bool obscureText;
  final Color? cursorColor;
  final double? width;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function()? onHideShowPasswordTap;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;

  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.lableText,
    this.obscureText = true,
    this.cursorColor,
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.onHideShowPasswordTap,
    this.validator,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onEditingComplete,
  });

  @override
  State<PasswordTextField> createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      obscureText: _isObscured,
      cursorColor: widget.cursorColor,
      width: widget.width,
      height: widget.height,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon ??
          (_isObscured
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility)),
      hintText: widget.hintText,
      lableText: widget.lableText,
      onSuffixIconTap: widget.onHideShowPasswordTap ??
          () => setState(() => _isObscured = !_isObscured),
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
