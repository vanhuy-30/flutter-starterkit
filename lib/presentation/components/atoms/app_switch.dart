import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';
import 'package:flutter_starter_kit/core/theme/text_styles.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? activeTrackColor;
  final String? label;
  final TextStyle? labelStyle;

  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.label,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        label != null
            ? Text(
                label!,
                style: labelStyle ?? AppTextStyles.bodyStyle(),
              )
            : const SizedBox.shrink(),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor ?? AppColors.primaryColor,
          activeTrackColor:
              activeTrackColor ?? AppColors.primaryColor.withOpacity(0.5),
        ),
      ],
    );
  }
}
