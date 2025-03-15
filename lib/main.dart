import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/routes/router.dart';
import 'package:flutter_starter_kit/core/services/hive_service.dart';
import 'package:flutter_starter_kit/core/services/locale_service.dart';
import 'package:flutter_starter_kit/core/services/preferences_service.dart';
import 'package:flutter_starter_kit/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_starter_kit/presentation/view_model/language_view_model.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final hiveService = HiveService();
  await hiveService.init();

  PreferencesService preferencesService = PreferencesService();
  await preferencesService.init();
  final localeService = LocaleService();

  const supportedLocales = [
    Locale('en'),
    Locale('vi'),
  ];

  runApp(
    EasyLocalization(
      supportedLocales: supportedLocales,
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      useFallbackTranslations: true,
      child: MultiProvider(
        providers: [
          Provider.value(value: hiveService),
          ChangeNotifierProvider(
            create: (_) => LanguageViewModel(
              preferencesService: preferencesService,
              localeService: localeService,
              supportedLocales: supportedLocales,
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'app_name'.tr(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: router(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
