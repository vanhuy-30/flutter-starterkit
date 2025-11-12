import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// App Step Item
/// Individual step item for stepper components
class AppStepItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final Widget? leading;
  final Widget? trailing;
  final AppStepState state;
  final VoidCallback? onTap;
  final bool isFirst;
  final bool isLast;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? completedColor;
  final double? stepSize;
  final double? lineHeight;
  final EdgeInsetsGeometry? padding;
  final bool showConnector;

  const AppStepItem({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.leading,
    this.trailing,
    this.state = AppStepState.inactive,
    this.onTap,
    this.isFirst = false,
    this.isLast = false,
    this.activeColor,
    this.inactiveColor,
    this.completedColor,
    this.stepSize = 24.0,
    this.lineHeight = 2.0,
    this.padding,
    this.showConnector = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step indicator and connector
        Column(
          children: [
            if (!isFirst && showConnector) ...[
              Container(
                width: lineHeight,
                height: 20,
                color: _getConnectorColor(),
              ),
            ],
            _buildStepIndicator(),
            if (!isLast && showConnector) ...[
              Container(
                width: lineHeight,
                height: 20,
                color: _getConnectorColor(),
              ),
            ],
          ],
        ),
        const SizedBox(width: 16),

        // Content
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              title,
                              fontWeight: FontWeight.w600,
                              color: _getTextColor(),
                            ),
                            if (subtitle != null) ...[
                              const SizedBox(height: 4),
                              AppText(
                                subtitle!,
                                color: AppColors.textSecondaryColor,
                                maxLines: 1,
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (trailing != null) trailing!,
                    ],
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 8),
                    AppText(
                      description!,
                      color: AppColors.textSecondaryColor,
                      maxLines: 3,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    switch (state) {
      case AppStepState.inactive:
        return _buildInactiveIndicator();
      case AppStepState.active:
        return _buildActiveIndicator();
      case AppStepState.completed:
        return _buildCompletedIndicator();
      case AppStepState.error:
        return _buildErrorIndicator();
    }
  }

  Widget _buildInactiveIndicator() {
    return Container(
      width: stepSize,
      height: stepSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: inactiveColor ??
            AppColors.textSecondaryColor.withValues(alpha: 0.3),
        border: Border.all(
          color: inactiveColor ?? AppColors.textSecondaryColor,
          width: 2,
        ),
      ),
      child: leading != null ? Center(child: leading) : null,
    );
  }

  Widget _buildActiveIndicator() {
    return Container(
      width: stepSize,
      height: stepSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: activeColor ?? AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color:
                (activeColor ?? AppColors.primaryColor).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: leading != null
          ? Center(
              child: AppIcon(
                icon: AppIcons.check,
                color: Colors.white,
                size: stepSize! * 0.6,
              ),
            )
          : Center(
              child: AppIcon(
                icon: AppIcons.check,
                color: Colors.white,
                size: stepSize! * 0.6,
              ),
            ),
    );
  }

  Widget _buildCompletedIndicator() {
    return Container(
      width: stepSize,
      height: stepSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: completedColor ?? AppColors.successColor,
      ),
      child: Center(
        child: AppIcon(
          icon: AppIcons.check,
          color: Colors.white,
          size: stepSize! * 0.6,
        ),
      ),
    );
  }

  Widget _buildErrorIndicator() {
    return Container(
      width: stepSize,
      height: stepSize,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.errorColor,
      ),
      child: Center(
        child: AppIcon(
          icon: AppIcons.close,
          color: Colors.white,
          size: stepSize! * 0.6,
        ),
      ),
    );
  }

  Color _getTextColor() {
    switch (state) {
      case AppStepState.inactive:
        return AppColors.textSecondaryColor;
      case AppStepState.active:
        return AppColors.primaryColor;
      case AppStepState.completed:
        return AppColors.textPrimaryColor;
      case AppStepState.error:
        return AppColors.errorColor;
    }
  }

  Color _getConnectorColor() {
    switch (state) {
      case AppStepState.inactive:
        return AppColors.textSecondaryColor.withValues(alpha: 0.3);
      case AppStepState.active:
        return AppColors.primaryColor.withValues(alpha: 0.3);
      case AppStepState.completed:
        return AppColors.successColor.withValues(alpha: 0.3);
      case AppStepState.error:
        return AppColors.errorColor.withValues(alpha: 0.3);
    }
  }
}

/// Specialized step item for numbered steps
class AppNumberedStepItem extends StatelessWidget {
  final int stepNumber;
  final String title;
  final String? subtitle;
  final String? description;
  final AppStepState state;
  final VoidCallback? onTap;
  final bool isFirst;
  final bool isLast;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? completedColor;
  final double? stepSize;
  final double? lineHeight;
  final EdgeInsetsGeometry? padding;
  final bool showConnector;

  const AppNumberedStepItem({
    super.key,
    required this.stepNumber,
    required this.title,
    this.subtitle,
    this.description,
    this.state = AppStepState.inactive,
    this.onTap,
    this.isFirst = false,
    this.isLast = false,
    this.activeColor,
    this.inactiveColor,
    this.completedColor,
    this.stepSize = 32.0,
    this.lineHeight = 2.0,
    this.padding,
    this.showConnector = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppStepItem(
      title: title,
      subtitle: subtitle,
      description: description,
      leading: _buildNumberIndicator(),
      state: state,
      onTap: onTap,
      isFirst: isFirst,
      isLast: isLast,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      completedColor: completedColor,
      stepSize: stepSize,
      lineHeight: lineHeight,
      padding: padding,
      showConnector: showConnector,
    );
  }

  Widget _buildNumberIndicator() {
    switch (state) {
      case AppStepState.inactive:
        return AppText(
          '$stepNumber',
          color: AppColors.textSecondaryColor,
          fontWeight: FontWeight.bold,
        );
      case AppStepState.active:
        return AppText(
          '$stepNumber',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        );
      case AppStepState.completed:
        return const AppIcon(
          icon: AppIcons.check,
          color: Colors.white,
          size: 16,
        );
      case AppStepState.error:
        return const AppIcon(
          icon: AppIcons.close,
          color: Colors.white,
          size: 16,
        );
    }
  }
}

/// Specialized step item for icon steps
class AppIconStepItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? description;
  final AppStepState state;
  final VoidCallback? onTap;
  final bool isFirst;
  final bool isLast;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? completedColor;
  final double? stepSize;
  final double? lineHeight;
  final EdgeInsetsGeometry? padding;
  final bool showConnector;

  const AppIconStepItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.description,
    this.state = AppStepState.inactive,
    this.onTap,
    this.isFirst = false,
    this.isLast = false,
    this.activeColor,
    this.inactiveColor,
    this.completedColor,
    this.stepSize = 32.0,
    this.lineHeight = 2.0,
    this.padding,
    this.showConnector = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppStepItem(
      title: title,
      subtitle: subtitle,
      description: description,
      leading: Icon(
        icon,
        size: stepSize! * 0.5,
        color: _getIconColor(),
      ),
      state: state,
      onTap: onTap,
      isFirst: isFirst,
      isLast: isLast,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      completedColor: completedColor,
      stepSize: stepSize,
      lineHeight: lineHeight,
      padding: padding,
      showConnector: showConnector,
    );
  }

  Color _getIconColor() {
    switch (state) {
      case AppStepState.inactive:
        return AppColors.textSecondaryColor;
      case AppStepState.active:
        return Colors.white;
      case AppStepState.completed:
        return Colors.white;
      case AppStepState.error:
        return Colors.white;
    }
  }
}

/// Step states
enum AppStepState {
  inactive,
  active,
  completed,
  error,
}
