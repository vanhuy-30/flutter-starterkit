import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/text_styles.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final String? label;
  final TextStyle? labelStyle;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged?.call(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: activeColor ?? AppColors.primaryColor,
            checkColor: checkColor ?? Colors.white,
          ),
          if (label != null)
            Text(
              label!,
              style: labelStyle ?? AppTextStyles.normal(),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
