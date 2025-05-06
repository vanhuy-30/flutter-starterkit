import 'package:flutter_starter_kit/core/constants.dart';

enum Environment { dev, staging, production }

class AppConfig {
  final String baseUrl;
  final bool enableLogging;

  AppConfig({required this.baseUrl, required this.enableLogging});
}

// Config based on the environment
final appConfig = AppConfig(
  baseUrl: AppConstants.apiBaseUrl,
  enableLogging: true,
);
