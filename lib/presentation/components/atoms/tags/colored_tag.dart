import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/tags/app_tag.dart';

class ColoredTag extends AppTag {
  final bool isLight;

  const ColoredTag({
    super.key,
    required super.text,
    super.color,
    this.isLight = true,
    super.textStyle,
    super.padding,
    super.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? AppColors.primaryColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
      ),
      child: Text(
        text,
        style: textStyle ??
            const TextStyle(
              color: AppColors.textPrimaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
      ),
    );
  }
}
