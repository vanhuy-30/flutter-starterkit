import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/providers/core_providers.dart';
import 'package:flutter_starter_kit/shared/view_model/theme_notifier.dart';

/// Main app providers
/// Tập trung tất cả providers chính của ứng dụng

// Export tất cả providers để dễ dàng import
export 'package:flutter_starter_kit/app/providers/core_providers.dart';
export 'package:flutter_starter_kit/features/auth/presentation/providers/auth_providers.dart';

// App-level providers
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final preferencesService = ref.watch(preferencesServiceProvider);
  return ThemeNotifier(preferencesService: preferencesService);
});
