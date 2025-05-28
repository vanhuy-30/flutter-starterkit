import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/services/app_update_service.dart';

mixin AppUpdateMixin<T extends StatefulWidget> on State<T> {
  final AppUpdateService _updateService = AppUpdateService();

  @override
  void initState() {
    super.initState();
    _checkForUpdatesOnStart();
  }

  Future<void> _checkForUpdatesOnStart() async {
    // Delay to ensure UI is rendered
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      final shouldShow = await _updateService.shouldShowUpdateDialog();
      if (shouldShow) {
        _showUpdateIfNeeded();
      }
    }
  }

  void _showUpdateIfNeeded() {
    // Override this method in the child widget to customize the display
  }

  // Utility method
  Future<void> checkUpdatesManually() async {
    final hasUpdate = await _updateService.checkForUpdates();
    if (hasUpdate && mounted) {
      _showUpdateIfNeeded();
    }
  }
}