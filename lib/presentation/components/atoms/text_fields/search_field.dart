import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/text_fields/app_text_field.dart';

class AppSearchField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool autofocus;
  final bool enabled;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;
  final InputDecoration? decoration;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final double? borderRadius;

  const AppSearchField({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onClear,
    this.autofocus = false,
    this.enabled = true,
    this.textInputAction = TextInputAction.search,
    this.onSubmitted,
    this.decoration,
    this.cursorColor,
    this.contentPadding,
    this.prefixIcon,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  State<AppSearchField> createState() => AppSearchFieldState();
}

class AppSearchFieldState extends State<AppSearchField> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
    widget.onChanged?.call(_controller.text);
  }

  void _clearText() {
    _controller.clear();
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _controller,
      hintText: widget.hintText ?? 'search_hint'.tr(),
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onSubmitted,
      cursorColor: widget.cursorColor ?? Theme.of(context).primaryColor,
      prefixIcon: widget.prefixIcon ??
          const Icon(
            Icons.search,
            color: AppColors.primaryColor,
          ),
      suffixIcon: _hasText
          ? IconButton(
              icon: const Icon(
                Icons.clear,
                color: AppColors.primaryColor,
              ),
              onPressed: _clearText,
            )
          : null,
      fillColor: widget.backgroundColor,
      style: Theme.of(context).textTheme.bodyMedium,
      keyboardType: TextInputType.text,
    );
  }
}
