import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/core/services/biometric_service.dart';
import 'package:flutter_starter_kit/core/services/hive_service.dart';
import 'package:flutter_starter_kit/core/services/locale_service.dart';
import 'package:flutter_starter_kit/core/services/preferences_service.dart';

/// Core services providers

final hiveServiceProvider = Provider<HiveService>((ref) {
  throw UnimplementedError('HiveService must be initialized in main()');
});

final preferencesServiceProvider = Provider<PreferencesService>((ref) {
  throw UnimplementedError('PreferencesService must be initialized in main()');
});

final localeServiceProvider = Provider<LocaleService>((ref) {
  return LocaleService();
});

final biometricServiceProvider = Provider<BiometricService>((ref) {
  throw UnimplementedError('BiometricService must be initialized in main()');
});
