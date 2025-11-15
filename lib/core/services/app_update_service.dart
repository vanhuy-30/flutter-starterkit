import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for checking and updating the app
class AppUpdateService {
  static final AppUpdateService _instance = AppUpdateService._internal();
  factory AppUpdateService() => _instance;
  AppUpdateService._internal();

  static const String _lastCheckKey = 'last_update_check';
  static const String _skipVersionKey = 'skip_version';

  // Default configuration
  static const Duration _checkInterval = Duration(hours: 24);

  /// Initialize the service and configure the upgrader
  Future<void> initialize({
    String? appStoreId, // iOS App Store ID
    String? playStoreId, // Android Play Store ID
    Duration? checkInterval,
    int? minDaysBetweenPrompts,
  }) async {
    // Configure Upgrader
    await Upgrader.clearSavedSettings();
  }

  /// Check for updates manually
  Future<bool> checkForUpdates() async {
    try {
      final upgrader = Upgrader();
      await upgrader.initialize();

      // Save the last check time
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_lastCheckKey, DateTime.now().millisecondsSinceEpoch);

      return upgrader.isUpdateAvailable();
    } catch (e) {
      debugPrint('Error checking for updates: $e');
      return false;
    }
  }

  /// Check if the update dialog should be shown
  Future<bool> shouldShowUpdateDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCheck = prefs.getInt(_lastCheckKey) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    // Check if the time interval has passed
    if (now - lastCheck < _checkInterval.inMilliseconds) {
      return false;
    }

    return checkForUpdates();
  }

  /// Widget wrapper with UpgradeAlert
  Widget buildUpgradeWrapper({
    required Widget child,
    AppUpdateConfig? config,
  }) {
    final upgradeConfig = config ?? AppUpdateConfig.defaultConfig();

    return UpgradeAlert(
      upgrader: _buildUpgrader(upgradeConfig),
      dialogStyle: upgradeConfig.dialogStyle,
      showIgnore: upgradeConfig.showIgnoreButton,
      showLater: upgradeConfig.showLaterButton,
      showReleaseNotes: upgradeConfig.showReleaseNotes,
      child: child,
    );
  }

  /// Widget card to display update information
  Widget buildUpgradeCard({
    AppUpdateConfig? config,
    EdgeInsets? margin,
  }) {
    final upgradeConfig = config ?? AppUpdateConfig.defaultConfig();

    return UpgradeCard(
      upgrader: _buildUpgrader(upgradeConfig),
      margin: margin ?? const EdgeInsets.all(16),
      showIgnore: upgradeConfig.showIgnoreButton,
      showLater: upgradeConfig.showLaterButton,
      showReleaseNotes: upgradeConfig.showReleaseNotes,
    );
  }

  /// Show custom update dialog
  Future<void> showCustomUpdateDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? newVersion,
    String? releaseNotes,
    VoidCallback? onUpdate,
    VoidCallback? onSkip,
    VoidCallback? onLater,
    bool forceUpdate = false,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: !forceUpdate,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                if (newVersion != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    'new_version'.tr(args: [newVersion]),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
                if (releaseNotes != null && releaseNotes.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    'whats_new'.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(releaseNotes),
                ],
              ],
            ),
          ),
          actions: [
            if (!forceUpdate && onSkip != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onSkip();
                },
                child: Text('skip'.tr()),
              ),
            if (!forceUpdate && onLater != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onLater();
                },
                child: Text('later'.tr()),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                onUpdate?.call();
              },
              child: Text('update'.tr()),
            ),
          ],
        );
      },
    );
  }

  /// Open the store to update the app
  Future<void> openStore() async {
    final upgrader = Upgrader();
    await upgrader.initialize();
    await upgrader.sendUserToAppStore();
  }

  /// Reset the saved settings
  Future<void> resetSettings() async {
    await Upgrader.clearSavedSettings();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastCheckKey);
    await prefs.remove(_skipVersionKey);
  }

  /// Create Upgrader instance with configuration
  Upgrader _buildUpgrader(AppUpdateConfig config) {
    return Upgrader(
      debugLogging: config.debugLogging,
      durationUntilAlertAgain: Duration(days: config.daysUntilAlertAgain),
      messages: config.customMessages,
    );
  }
}

/// Configuration for App Update Service
class AppUpdateConfig {
  final bool showIgnoreButton;
  final bool showLaterButton;
  final bool showReleaseNotes;
  final bool debugLogging;
  final int daysUntilAlertAgain;
  final UpgradeDialogStyle dialogStyle;
  final UpgraderMessages? customMessages;

  const AppUpdateConfig({
    this.showIgnoreButton = true,
    this.showLaterButton = true,
    this.showReleaseNotes = true,
    this.debugLogging = false,
    this.daysUntilAlertAgain = 1,
    this.dialogStyle = UpgradeDialogStyle.material,
    this.customMessages,
  });

  factory AppUpdateConfig.defaultConfig() {
    return const AppUpdateConfig();
  }

  factory AppUpdateConfig.forceUpdate() {
    return const AppUpdateConfig(
      showIgnoreButton: false,
      showLaterButton: false,
      daysUntilAlertAgain: 0,
    );
  }
}
