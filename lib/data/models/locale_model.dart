// lib/models/locale_model.dart
import 'package:flutter/material.dart';

class LocaleModel {
  final Locale locale;
  final String flagPath;
  final String name;

  LocaleModel({
    required this.locale,
    required this.flagPath,
    required this.name,
  });
}
