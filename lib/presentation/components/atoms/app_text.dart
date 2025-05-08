import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// A customizable auto-sizing text widget for consistent usage across the app.
///
/// Automatically adjusts the font size based on available space.
/// Provides convenient parameters for common text customization.
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final double minFontSize;
  final double maxFontSize;
  final TextOverflow overflow;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final TextDecoration? decoration;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines = 1,
    this.minFontSize = 12,
    this.maxFontSize = 18,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      overflow: overflow,
      style: style ??
          TextStyle(
            fontWeight: fontWeight ?? FontWeight.normal,
            color: color ?? Colors.black,
            letterSpacing: letterSpacing,
            decoration: decoration,
          ),
    );
  }
}
