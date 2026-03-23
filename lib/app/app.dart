import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/routes/app_router.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_starter_kit/features/settings/presentation/state/settings_providers.dart';
import 'package:flutter_starter_kit/app/providers/app_providers.dart';
import 'package:flutter_starter_kit/shared/design_system/widgets/app_lifecycle_manager.dart';

class AppInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Set system UI overlay style for entire app
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize language provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(languageProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageState = ref.watch(languageProvider);
    final themeState = ref.watch(themeNotifierProvider);

    return AppLifecycleManager(
      child: MaterialApp.router(
        title: 'app_name'.tr(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeState.themeMode,
        routerConfig: appRouter,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: languageState.currentLocale,
      ),
    );
  }
}
