import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/assets/images.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/avatar_images/app_circular_avatar.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/text_styles.dart';

/// Settings Avatar Widget
/// Displays user profile information with circular avatar and edit functionality
class SettingsAvatar extends StatelessWidget {
  final String name;
  final String username;
  final String? avatarUrl;
  final VoidCallback? onEditPressed;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const SettingsAvatar({
    super.key,
    required this.name,
    required this.username,
    this.avatarUrl,
    this.onEditPressed,
    this.onTap,
    this.backgroundColor,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          AppCircularAvatar(
            assetImagePath: avatarImg,
            name: name,
            radius: 60,
            backgroundColor: AppColors.primaryColor,
            isEditable: true,
            onEditPressed: onEditPressed,
            editIconBackgroundColor: AppColors.primaryColor,
            editIconColor: Colors.white,
            editButtonSize: 22,
            editIconSize: 16,
          ),
          AppText(
            name,
            style: AppTextStyles.bold(),
          ),
          const SizedBox(height: 4),
          AppText(
            '@$username',
            style: AppTextStyles.normal(),
          ),
        ],
      ),
    );
  }
}
