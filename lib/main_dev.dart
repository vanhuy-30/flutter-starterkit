import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_starter_kit/main.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env.dev");
  runApp(const MyApp());
}
