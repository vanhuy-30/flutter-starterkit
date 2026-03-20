import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// Common reusable widgets for better performance
/// These widgets are extracted from organisms to avoid rebuilds

/// Empty state widget
class AppEmptyState extends StatelessWidget {
  final String message;
  final String? description;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionText;

  const AppEmptyState({
    super.key,
    required this.message,
    this.description,
    this.icon,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              AppIcon(
                icon: icon,
                size: 64,
                color: AppColors.textSecondaryColor,
              ),
              const SizedBox(height: 24),
            ],
            AppAutoSizeText(
              message,
              maxFontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor,
              textAlign: TextAlign.center,
            ),
            if (description != null) ...[
              const SizedBox(height: 8),
              AppAutoSizeText(
                description!,
                maxFontSize: 14,
                color: AppColors.textSecondaryColor,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ],
            if (onAction != null && actionText != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                child: AppText(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Section header widget
class AppSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onSeeAllPressed;
  final String? seeAllText;
  final bool showDivider;

  const AppSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onSeeAllPressed,
    this.seeAllText = 'See all',
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppAutoSizeText(
                    title,
                    maxFontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimaryColor,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    AppAutoSizeText(
                      subtitle!,
                      maxFontSize: 14,
                      color: AppColors.textSecondaryColor,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
            if (onSeeAllPressed != null) ...[
              const SizedBox(width: 8),
              TextButton(
                onPressed: onSeeAllPressed,
                child: AppText(
                  seeAllText!,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
        if (showDivider) ...[
          const SizedBox(height: 8),
          const Divider(height: 1),
        ],
      ],
    );
  }
}

/// Page indicator widget
class AppPageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color? activeColor;
  final Color? inactiveColor;
  final double size;

  const AppPageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.activeColor,
    this.inactiveColor,
    this.size = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalPages,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage
                ? (activeColor ?? AppColors.primaryColor)
                : (inactiveColor ??
                    AppColors.textSecondaryColor.withValues(alpha: 0.3)),
          ),
        ),
      ),
    );
  }
}

/// Error message widget
class AppErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? retryText;

  const AppErrorMessage({
    super.key,
    required this.message,
    this.onRetry,
    this.retryText = 'Retry',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.errorColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.errorColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const AppIcon(
                icon: AppIcons.errorOutlined,
                color: AppColors.errorColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppAutoSizeText(
                  message,
                  color: AppColors.errorColor,
                  maxFontSize: 14,
                ),
              ),
            ],
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onRetry,
                child: AppText(
                  retryText!,
                  color: AppColors.errorColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
