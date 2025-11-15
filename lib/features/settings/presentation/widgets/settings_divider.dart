import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_divider.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDivider(
      color: Colors.grey.shade300,
      horizontalMargin: 2,
    );
  }
}
