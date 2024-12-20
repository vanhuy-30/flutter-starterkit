import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();

  factory PreferencesService() {
    return _instance;
  }

  PreferencesService._internal();

  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setDarkMode(bool isDarkMode) async {
    await _preferences?.setBool('darkMode', isDarkMode);
  }

  bool getDarkMode() {
    return _preferences?.getBool('darkMode') ?? false;
  }
}
