import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';

class LinearLoader extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final double? value;

  const LinearLoader({
    super.key,
    this.color,
    this.height,
    this.width,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? 4.0,
        width: width ?? 40.0,
        child: LinearProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(color ?? AppColors.primaryColor),
          value: value,
        ));
  }
}
