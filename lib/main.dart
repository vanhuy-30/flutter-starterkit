// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_kit/core/routes/router.dart';
import 'package:flutter_starter_kit/core/services/hive_service.dart';
import 'package:flutter_starter_kit/core/services/locale_service.dart';
import 'package:flutter_starter_kit/core/services/preferences_service.dart';
import 'package:flutter_starter_kit/core/services/biometric_service.dart';
import 'package:flutter_starter_kit/core/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_starter_kit/presentation/view_model/language_view_model.dart';
import 'package:provider/provider.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'presentation/viewmodels/login_viewmodel.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await EasyLocalization.ensureInitialized();

  final hiveService = HiveService();
  await hiveService.init();

  PreferencesService preferencesService = PreferencesService();
  await preferencesService.init();
  final localeService = LocaleService();

  // Initialize biometric service
  final biometricService = BiometricService();
  await biometricService.initialize();

  const supportedLocales = [
    Locale('en'),
    Locale('vi'),
  ];

  // Initialize repositories
  final authRepository = AuthRepositoryImpl();

  // Initialize use cases
  final loginUseCase = LoginUseCase(authRepository);

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
          Provider.value(value: biometricService),
          Provider<LoginUseCase>.value(value: loginUseCase),
          ChangeNotifierProvider(
            create: (_) => LanguageViewModel(
              preferencesService: preferencesService,
              localeService: localeService,
              supportedLocales: supportedLocales,
            ),
          ),
          ChangeNotifierProxyProvider<LoginUseCase, LoginViewModel>(
            create: (context) => LoginViewModel(context.read<LoginUseCase>()),
            update: (context, loginUseCase, previous) =>
                previous ?? LoginViewModel(loginUseCase),
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
