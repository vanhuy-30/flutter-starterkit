import 'package:workmanager/workmanager.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

class BackgroundTaskService {
  static final BackgroundTaskService _instance = BackgroundTaskService._internal();
  factory BackgroundTaskService() => _instance;
  BackgroundTaskService._internal();

  final Workmanager _workmanager = Workmanager();
  bool _isInitialized = false;

  // Task names
  static const String syncDataTask = 'syncDataTask';
  static const String cleanupTask = 'cleanupTask';
  static const String notificationTask = 'notificationTask';

  // Initialize service
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );

    _isInitialized = true;
  }

  // Register periodic task
  Future<void> registerPeriodicTask({
    required String taskName,
    required Duration frequency,
    Map<String, dynamic>? inputData,
    bool requiresNetworkConnectivity = false,
    bool requiresBatteryNotLow = false,
    bool requiresCharging = false,
    bool requiresDeviceIdle = false,
    bool requiresStorageNotLow = false,
  }) async {
    if (!_isInitialized) await initialize();

    await _workmanager.registerPeriodicTask(
      taskName,
      taskName,
      frequency: frequency,
      constraints: Constraints(
        networkType: requiresNetworkConnectivity
            ? NetworkType.connected
            : NetworkType.not_required,
        requiresBatteryNotLow: requiresBatteryNotLow,
        requiresCharging: requiresCharging,
        requiresDeviceIdle: requiresDeviceIdle,
        requiresStorageNotLow: requiresStorageNotLow,
      ),
      initialDelay: const Duration(seconds: 10),
      backoffPolicy: BackoffPolicy.linear,
      backoffPolicyDelay: const Duration(minutes: 15),
      inputData: inputData,
    );
  }

  // Register one-off task
  Future<void> registerOneOffTask({
    required String taskName,
    Map<String, dynamic>? inputData,
    bool requiresNetworkConnectivity = false,
    bool requiresBatteryNotLow = false,
    bool requiresCharging = false,
    bool requiresDeviceIdle = false,
    bool requiresStorageNotLow = false,
  }) async {
    if (!_isInitialized) await initialize();

    await _workmanager.registerOneOffTask(
      taskName,
      taskName,
      initialDelay: const Duration(seconds: 10),
      constraints: Constraints(
        networkType: requiresNetworkConnectivity
            ? NetworkType.connected
            : NetworkType.not_required,
        requiresBatteryNotLow: requiresBatteryNotLow,
        requiresCharging: requiresCharging,
        requiresDeviceIdle: requiresDeviceIdle,
        requiresStorageNotLow: requiresStorageNotLow,
      ),
      backoffPolicy: BackoffPolicy.linear,
      backoffPolicyDelay: const Duration(minutes: 15),
      inputData: inputData,
    );
  }

  // Cancel task
  Future<void> cancelTask(String taskName) async {
    await _workmanager.cancelByUniqueName(taskName);
  }

  // Cancel all tasks
  Future<void> cancelAllTasks() async {
    await _workmanager.cancelAll();
  }
}

// Callback dispatcher
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      switch (taskName) {
        case BackgroundTaskService.syncDataTask:
          await _handleSyncDataTask(inputData);
          break;
        case BackgroundTaskService.cleanupTask:
          await _handleCleanupTask(inputData);
          break;
        case BackgroundTaskService.notificationTask:
          await _handleNotificationTask(inputData);
          break;
        default:
          debugPrint('Unknown task: $taskName');
      }
      return true;
    } catch (e) {
      debugPrint('Error executing task $taskName: $e');
      return false;
    }
  });
}

// Task handlers
Future<void> _handleSyncDataTask(Map<String, dynamic>? inputData) async {
  // Implement sync data logic
  debugPrint('Syncing data...');
  await Future.delayed(const Duration(seconds: 5));
  debugPrint('Data sync completed');
}

Future<void> _handleCleanupTask(Map<String, dynamic>? inputData) async {
  // Implement cleanup logic
  debugPrint('Cleaning up...');
  await Future.delayed(const Duration(seconds: 5));
  debugPrint('Cleanup completed');
}

Future<void> _handleNotificationTask(Map<String, dynamic>? inputData) async {
  // Implement notification logic
  debugPrint('Sending notification...');
  await Future.delayed(const Duration(seconds: 5));
  debugPrint('Notification sent');
} 