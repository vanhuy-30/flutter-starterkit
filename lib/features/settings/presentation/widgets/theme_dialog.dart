import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/providers/app_providers.dart';
import 'package:flutter_starter_kit/features/settings/presentation/state/settings_providers.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// Dialog for selecting theme
class ThemeDialog extends ConsumerWidget {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeNotifierProvider);
    final settingsState = ref.watch(settingsNotifierProvider);

    return AlertDialog(
      title: AppText('select_theme'.tr()),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.light_mode),
            title: AppText('light_mode'.tr()),
            trailing: !themeState.isDarkMode
                ? const Icon(Icons.check, color: AppColors.primaryColor)
                : null,
            onTap: () async {
              if (themeState.isDarkMode && !settingsState.isLoading) {
                try {
                  await ref
                      .read(settingsNotifierProvider.notifier)
                      .toggleTheme();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error changing theme: $e'),
                      ),
                    );
                  }
                }
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: AppText('dark_mode'.tr()),
            trailing: themeState.isDarkMode
                ? const Icon(Icons.check, color: AppColors.primaryColor)
                : null,
            onTap: () async {
              if (!themeState.isDarkMode && !settingsState.isLoading) {
                try {
                  await ref
                      .read(settingsNotifierProvider.notifier)
                      .toggleTheme();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error changing theme: $e'),
                      ),
                    );
                  }
                }
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: AppText('cancel'.tr()),
        ),
      ],
    );
  }
}
