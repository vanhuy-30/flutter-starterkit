import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// Settings Card Widget
/// A reusable card widget for settings items with title and chevron
class SettingsCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool enabled;

  const SettingsCard({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.margin,
    this.enabled = true,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 4, horizontal: 14),
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(title),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    AppText(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const AppIcon(
              icon: Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
