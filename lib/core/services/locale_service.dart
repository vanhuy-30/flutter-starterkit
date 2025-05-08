import 'dart:ui';

class LocaleService {
  static final LocaleService _instance = LocaleService._internal();

  factory LocaleService() {
    return _instance;
  }

  LocaleService._internal();

  Locale? getDeviceLocale() {
    final deviceLocale = PlatformDispatcher.instance.locale;
    return deviceLocale;
  }

  bool isLanguageSupported(String languageCode, List<Locale> supportedLocales) {
    return supportedLocales.any((locale) => locale.languageCode == languageCode);
  }

  Locale getDefaultLocale(List<Locale> supportedLocales) {
    final deviceLocale = getDeviceLocale();
    if (deviceLocale != null && 
        isLanguageSupported(deviceLocale.languageCode, supportedLocales)) {
      return deviceLocale;
    }
    return const Locale('en');
  }
}