import 'package:flutter/material.dart';

/// Base class for tag atoms with shared configuration
abstract class AppTag extends StatelessWidget {
  final String text;
  final Color? color;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double? borderRadius;

  const AppTag({
    super.key,
    required this.text,
    this.color,
    this.textStyle,
    this.padding,
    this.borderRadius,
  });
}