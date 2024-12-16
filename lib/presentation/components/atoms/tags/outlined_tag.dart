import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/tags/app_tag.dart';

class OutlinedTag extends AppTag {
  const OutlinedTag({
    super.key,
    required super.text,
    super.color,
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
        border: Border.all(color: color ?? Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
      ),
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              color: color ?? Colors.blue,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
      ),
    );
  }
}
