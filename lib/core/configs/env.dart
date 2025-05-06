import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get apiUrl => dotenv.env['API_URL'] ?? '';
  static String get env => dotenv.env['ENV'] ?? 'unknown';
}
