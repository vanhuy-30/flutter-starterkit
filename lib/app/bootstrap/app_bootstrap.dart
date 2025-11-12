import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/app.dart';
import 'package:flutter_starter_kit/core/services/hive_service.dart';
import 'package:flutter_starter_kit/core/services/preferences_service.dart';
import 'package:flutter_starter_kit/core/services/biometric_service.dart';
import 'package:flutter_starter_kit/app/providers/app_providers.dart';
import 'package:flutter_starter_kit/core/configs/constants.dart';

/// Bootstrap class to handle app initialization
class AppBootstrap {
  static Future<void> run({
    required String envFile,
  }) async {
    try {
      // Load environment variables
      await dotenv.load(fileName: envFile);

      // Initialize app
      await AppInitializer.initialize();

      // Initialize localization
      await EasyLocalization.ensureInitialized();

      // Initialize services
      await _initializeServices();

      // Run the app
      runApp(_buildApp());
    } catch (e) {
      // Handle initialization errors
      debugPrint('App initialization failed: $e');
      runApp(_buildErrorApp(e.toString()));
    }
  }

  static Future<void> _initializeServices() async {
    final hiveService = HiveService();
    await hiveService.init();

    final preferencesService = PreferencesService();
    await preferencesService.init();

    final biometricService = BiometricService();
    await biometricService.initialize();

    // Store services in providers for dependency injection
    _hiveService = hiveService;
    _preferencesService = preferencesService;
    _biometricService = biometricService;
  }

  static Widget _buildApp() {
    return EasyLocalization(
      supportedLocales: AppConstants.supportedLocales,
      path: AppConstants.translationsPath,
      fallbackLocale: AppConstants.fallbackLocale,
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      child: ProviderScope(
        overrides: [
          hiveServiceProvider.overrideWithValue(_hiveService!),
          preferencesServiceProvider.overrideWithValue(_preferencesService!),
          biometricServiceProvider.overrideWithValue(_biometricService!),
        ],
        child: const MyApp(),
      ),
    );
  }

  static Widget _buildErrorApp(String error) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'App Initialization Failed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Private static variables to store initialized services
  static HiveService? _hiveService;
  static PreferencesService? _preferencesService;
  static BiometricService? _biometricService;
}
