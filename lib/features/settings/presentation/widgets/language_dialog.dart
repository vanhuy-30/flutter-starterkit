import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/providers/app_providers.dart';
import 'package:flutter_starter_kit/features/settings/presentation/state/language_provider.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// Dialog for selecting language
class LanguageDialog extends ConsumerWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageState = ref.watch(languageProvider);
    final settingsState = ref.watch(settingsNotifierProvider);
    final availableLanguages = ref.read(availableLanguagesProvider);

    return AlertDialog(
      title: AppText('select_language'.tr()),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: availableLanguages.map((language) {
          final isSelected = language.locale.languageCode ==
              languageState.currentLocale.languageCode;

          return ListTile(
            leading: Image.asset(
              language.flagPath,
              width: 24,
              height: 24,
            ),
            title: AppText(language.name),
            trailing: isSelected
                ? const Icon(Icons.check, color: AppColors.primaryColor)
                : null,
            onTap: () async {
              if (!isSelected && !settingsState.isLoading) {
                try {
                  await ref
                      .read(settingsNotifierProvider.notifier)
                      .changeLanguage(language.locale);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${'error_changing_language'.tr()}: $e'),
                      ),
                    );
                  }
                }
              }
            },
          );
        }).toList(),
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
