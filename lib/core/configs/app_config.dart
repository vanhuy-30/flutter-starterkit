import 'package:flutter_starter_kit/core/configs/env.dart';

enum Environment { dev, staging, production }

class AppConfig {
  final String baseUrl;
  final bool enableLogging;
  final bool enableAnalytics;
  final bool enableCrashReporting;

  const AppConfig({
    required this.baseUrl,
    required this.enableLogging,
    required this.enableAnalytics,
    required this.enableCrashReporting,
  });

  // Factory method to create config based on environment
  factory AppConfig.fromEnvironment(Environment environment) {
    switch (environment) {
      case Environment.dev:
        return AppConfig(
          baseUrl: Env.apiUrl.isNotEmpty
              ? Env.apiUrl
              : 'https://dev-api.myawesomeapp.com',
          enableLogging: true,
          enableAnalytics: false,
          enableCrashReporting: false,
        );
      case Environment.staging:
        return AppConfig(
          baseUrl: Env.apiUrl.isNotEmpty
              ? Env.apiUrl
              : 'https://staging-api.myawesomeapp.com',
          enableLogging: true,
          enableAnalytics: true,
          enableCrashReporting: true,
        );
      case Environment.production:
        return AppConfig(
          baseUrl: Env.apiUrl.isNotEmpty
              ? Env.apiUrl
              : 'https://api.myawesomeapp.com',
          enableLogging: false,
          enableAnalytics: true,
          enableCrashReporting: true,
        );
    }
  }
}

// Current environment - can be set from main.dart or build flavor
Environment get currentEnvironment {
  final envString = Env.env.toLowerCase();
  switch (envString) {
    case 'dev':
      return Environment.dev;
    case 'staging':
      return Environment.staging;
    case 'production':
      return Environment.production;
    default:
      return Environment.dev; // Default to dev
  }
}

// Global config instance
final appConfig = AppConfig.fromEnvironment(currentEnvironment);
