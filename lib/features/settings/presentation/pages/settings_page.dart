import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/features/settings/presentation/widgets/settings_card.dart';
import 'package:flutter_starter_kit/features/settings/presentation/widgets/settings_divider.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/features/settings/presentation/widgets/settings_avatar.dart';
import 'package:flutter_starter_kit/features/settings/presentation/widgets/language_dialog.dart';
import 'package:flutter_starter_kit/features/settings/presentation/widgets/theme_dialog.dart';
import 'package:flutter_starter_kit/features/settings/presentation/state/settings_providers.dart';
import 'package:flutter_starter_kit/app/providers/app_providers.dart';
import 'package:flutter_starter_kit/shared/design_system/molecules/app_dialog.dart';
import 'package:flutter_starter_kit/app/routes/route_paths.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final themeState = ref.watch(themeNotifierProvider);
    final currentTheme = themeState.isDarkMode ? 'dark_mode' : 'light_mode';

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: AppText(
          'settings'.tr(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User Profile Section
          SettingsAvatar(
            name: currentUser?.name ?? 'Guest User',
            username: currentUser?.email ?? 'guest@example.com',
            avatarUrl: currentUser?.avatarUrl,
            onEditPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('edit_avatar_pressed'.tr())),
              );
            },
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('profile_tapped'.tr())),
              );
            },
          ),

          const SizedBox(height: 30),

          // Language Card
          SettingsCard(
            title: 'language'.tr(),
            onTap: () => showDialog(
              context: context,
              builder: (context) => const LanguageDialog(),
            ),
          ),

          const SizedBox(height: 12),
          const SettingsDivider(),
          const SizedBox(height: 12),

          // Theme Card
          SettingsCard(
            title: 'theme'.tr(),
            subtitle:
                themeState.isLoading ? 'loading...'.tr() : currentTheme.tr(),
            onTap: () => showDialog(
              context: context,
              builder: (context) => const ThemeDialog(),
            ),
          ),

          const SizedBox(height: 12),
          const SettingsDivider(),
          const SizedBox(height: 12),

          // Logout Card
          SettingsCard(
            title: 'logout'.tr(),
            onTap: () => AppDialog.showConfirmation(
              context: context,
              title: 'logout'.tr(),
              message: 'logout_confirmation'.tr(),
              confirmText: 'logout'.tr(),
              cancelText: 'cancel'.tr(),
              onConfirm: () async {
                await ref.read(settingsNotifierProvider.notifier).logout();
                if (context.mounted) {
                  context.go(Routes.login);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
