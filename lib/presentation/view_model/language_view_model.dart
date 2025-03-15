import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/images_assets.dart';
import 'package:flutter_starter_kit/core/services/locale_service.dart';
import 'package:flutter_starter_kit/core/services/preferences_service.dart';
import 'package:flutter_starter_kit/data/models/locale_model.dart';

class LanguageViewModel extends ChangeNotifier {
  final PreferencesService _preferencesService;
  final LocaleService _localeService;
  late Locale _currentLocale;
  final List<Locale> supportedLocales;

  static List<LocaleModel> languages = [
    LocaleModel(locale: const Locale('en'), name: 'English', flagPath: icEnglandFlag),
    LocaleModel(locale: const Locale('vi'), name: 'Tiếng Việt', flagPath: icVietnamFlag),
  ];

  LanguageViewModel({
    required PreferencesService preferencesService,
    required LocaleService localeService,
    required this.supportedLocales,
  }) : _preferencesService = preferencesService,
       _localeService = localeService {
    _loadInitialLanguage();
  }

  Locale get currentLocale => _currentLocale;
  List<LocaleModel> get availableLanguages => languages;

  void _loadInitialLanguage() {
    final savedLocale = _preferencesService.getLocale();
    _currentLocale = savedLocale ?? _localeService.getDefaultLocale(supportedLocales);
    notifyListeners();
  }

  LocaleModel getCurrentLanguage() {
    return languages.firstWhere(
      (lang) => lang.locale.languageCode == _currentLocale.languageCode,
      orElse: () => languages.first,
    );
  }

  Future<void> changeLanguage(Locale newLocale) async {
    _currentLocale = newLocale;
    await _preferencesService.setLocale(newLocale);
    notifyListeners();
  }

  // Future<void> useDeviceLanguage() async {
  //   await _preferencesService.setLocale(null);
  //   _currentLocale = _localeService.getDefaultLocale(supportedLocales);
  //   notifyListeners();
  // }
}