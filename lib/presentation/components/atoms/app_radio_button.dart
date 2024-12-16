import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';
import 'package:flutter_starter_kit/core/theme/text_styles.dart';

class AppRadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Color? activeColor;
  final String? label;
  final TextStyle? labelStyle;

  const AppRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
    this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged?.call(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: activeColor ?? AppColors.primaryColor,
          ),
          label != null
              ? Text(
                  label!,
                  style: labelStyle ?? AppTextStyles.bodyStyle(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
