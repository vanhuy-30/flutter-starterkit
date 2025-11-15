import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/buttons/app_button.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// App Dialog
/// Provides various types of dialogs for the app
class AppDialog {
  /// Show confirmation dialog
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Xác nhận',
    String cancelText = 'Hủy',
    Color? confirmColor,
    Color? cancelColor,
    VoidCallback? onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: AppText(
          title,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimaryColor,
        ),
        content: AppText(
          message,
          color: AppColors.textSecondaryColor,
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: AppText(
              cancelText,
              color: cancelColor ?? AppColors.textSecondaryColor,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              onConfirm?.call();
            },
            child: AppText(
              confirmText,
              color: confirmColor ?? AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Show info dialog
  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            const AppIcon(
              icon: AppIcons.infoOutlined,
              color: AppColors.primaryColor,
              size: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppText(
                title,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ],
        ),
        content: AppText(
          message,
          color: AppColors.textSecondaryColor,
          maxLines: 5,
        ),
        actions: [
          AppButton(
            text: buttonText,
            width: 100,
            height: 40,
            onPressed: () {
              Navigator.of(context).pop();
              onPressed?.call();
            },
          ),
        ],
      ),
    );
  }

  /// Show error dialog
  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            const AppIcon(
              icon: AppIcons.errorOutlined,
              color: AppColors.errorColor,
              size: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppText(
                title,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ],
        ),
        content: AppText(
          message,
          color: AppColors.textSecondaryColor,
          maxLines: 5,
        ),
        actions: [
          AppButton(
            text: buttonText,
            color: AppColors.errorColor,
            width: 100,
            height: 40,
            onPressed: () {
              Navigator.of(context).pop();
              onPressed?.call();
            },
          ),
        ],
      ),
    );
  }

  /// Show success dialog
  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
    VoidCallback? onPressed,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            const AppIcon(
              icon: AppIcons.successOutlined,
              color: AppColors.successColor,
              size: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AppText(
                title,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ],
        ),
        content: AppText(
          message,
          color: AppColors.textSecondaryColor,
          maxLines: 5,
        ),
        actions: [
          AppButton(
            text: buttonText,
            color: AppColors.successColor,
            width: 100,
            height: 40,
            onPressed: () {
              Navigator.of(context).pop();
              onPressed?.call();
            },
          ),
        ],
      ),
    );
  }

  /// Show loading dialog
  static Future<void> showLoading({
    required BuildContext context,
    String message = 'Đang tải...',
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
            const SizedBox(height: 16),
            AppText(
              message,
              color: AppColors.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  /// Show custom dialog
  static Future<T?> showCustom<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (context) => child,
    );
  }
}

/// Custom dialog widget for complex dialogs
class AppCustomDialog extends StatelessWidget {
  final String? title;
  final Widget content;
  final List<Widget>? actions;
  final bool showCloseButton;
  final VoidCallback? onClose;

  const AppCustomDialog({
    super.key,
    this.title,
    required this.content,
    this.actions,
    this.showCloseButton = true,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title != null || showCloseButton) ...[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    if (title != null)
                      Expanded(
                        child: AppText(
                          title!,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                    if (showCloseButton)
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onClose?.call();
                        },
                        icon: const AppIcon(
                          icon: AppIcons.close,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                  ],
                ),
              ),
              const Divider(height: 1),
            ],
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: content,
              ),
            ),
            if (actions != null) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
