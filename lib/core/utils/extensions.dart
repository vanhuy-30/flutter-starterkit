import 'package:easy_localization/easy_localization.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension DateTimeExtension on DateTime {
  String toEEEddMMYYYYHHmm() {
    return DateFormat('EEE, dd/MM/yyyy, HH:mm').format(this);
  }

  String toddMMYYYY() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  String orEmpty() => this ?? '';
}

extension IterableExtension<T> on Iterable<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  T? firstWhereOrNull(bool Function(T element) test) {
    if (isNullOrEmpty) return null;
    for (var element in this!.toList()) {
      if (test(element)) return element;
    }
    return null;
  }
}
