import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/routes/router.dart';
import 'package:flutter_starter_kit/core/services/preferences_service.dart';
import 'package:flutter_starter_kit/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_starter_kit/data/models/product/product.dart';
import 'package:flutter_starter_kit/data/models/user/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<User>('users');
  await Hive.openBox<Product>('products');

  PreferencesService preferencesService = PreferencesService();
  await preferencesService.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      useOnlyLangCode: true,
      child: const MyApp(),
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
