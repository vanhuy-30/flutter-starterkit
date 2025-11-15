import 'package:intl/intl.dart';

/// Utility formatters for the application
class Formatters {
  Formatters._();

  // CURRENCY FORMATTERS

  /// Format Vietnamese Dong currency
  static String formatVND(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// Format US Dollar currency
  static String formatUSD(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_US',
      symbol: r'$',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  /// Format currency with custom symbol
  static String formatCurrency(
    double amount, {
    String symbol = '₫',
    int decimalDigits = 0,
    String locale = 'vi_VN',
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  /// Format number with thousand separators
  static String formatNumber(double number, {int decimalDigits = 0}) {
    final formatter = NumberFormat('#,##0.${'0' * decimalDigits}');
    return formatter.format(number);
  }

  // DATE & TIME FORMATTERS

  /// Format date in Vietnamese format (dd/MM/yyyy)
  static String formatDateVN(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Format date in ISO format (yyyy-MM-dd)
  static String formatDateISO(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Format time (HH:mm)
  static String formatTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  /// Format full date and time (dd/MM/yyyy HH:mm)
  static String formatDateTimeVN(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  /// Format date with month name (dd MMMM yyyy)
  static String formatDateWithMonthName(DateTime date, {String locale = 'vi'}) {
    return DateFormat('dd MMMM yyyy', locale).format(date);
  }

  /// Format relative time (2 days ago, 1 hour ago)
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }

  /// Format date time with custom pattern
  static String formatCustomDateTime(
    DateTime date,
    String pattern, {
    String locale = 'vi',
  }) {
    return DateFormat(pattern, locale).format(date);
  }

  // PHONE FORMATTERS

  /// Format Vietnamese phone number (10-11 digits)
  static String formatPhoneVN(String phone) {
    // Remove all non-digit characters
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');

    if (cleaned.length == 10) {
      // Format: 0xxx xxx xxx
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 7)} ${cleaned.substring(7)}';
    } else if (cleaned.length == 11 && cleaned.startsWith('0')) {
      // Format: 0xxx xxx xxxx
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 7)} ${cleaned.substring(7)}';
    } else if (cleaned.length == 9 && cleaned.startsWith('9')) {
      // Format: 9xx xxx xxx (mobile without leading 0)
      return '${cleaned.substring(0, 3)} ${cleaned.substring(3, 6)} ${cleaned.substring(6)}';
    }

    return phone; // Return original if invalid format
  }

  /// Validate Vietnamese phone number
  static bool isValidPhoneVN(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    return RegExp(r'^(0[3|5|7|8|9])[0-9]{8}$').hasMatch(cleaned) ||
        RegExp(r'^9[0-9]{8}$').hasMatch(cleaned);
  }

  /// Format international phone number
  static String formatInternationalPhone(String phone,
      {String countryCode = '+84'}) {
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.startsWith('0')) {
      return '$countryCode${cleaned.substring(1)}';
    }
    return '$countryCode$cleaned';
  }

  // TEXT FORMATTERS

  /// Validate email format
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Format email (convert to lowercase)
  static String formatEmail(String email) {
    return email.trim().toLowerCase();
  }

  /// Validate URL format
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  /// Format name (capitalize first letter of each word)
  static String formatName(String name) {
    if (name.isEmpty) return name;

    return name
        .split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : '')
        .join(' ')
        .trim();
  }

  /// Truncate text with ellipsis
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Clean excessive whitespace
  static String cleanWhitespace(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Format address
  static String formatAddress(String address) {
    return cleanWhitespace(address).replaceAll(RegExp(r'\s*,\s*'), ', ');
  }

  // SPECIAL FORMATTERS

  /// Format OTP (add spaces between digits)
  static String formatOTP(String otp) {
    final cleaned = otp.replaceAll(RegExp(r'[^\d]'), '');
    return cleaned.split('').join(' ');
  }

  /// Format credit card (hide middle digits)
  static String formatCreditCard(String cardNumber) {
    final cleaned = cardNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length < 8) return cardNumber;

    final start = cleaned.substring(0, 4);
    final end = cleaned.substring(cleaned.length - 4);
    final middle = '*' * (cleaned.length - 8);

    return '$start $middle $end';
  }

  /// Format tax code
  static String formatTaxCode(String taxCode) {
    final cleaned = taxCode.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length != 10 && cleaned.length != 13) return taxCode;

    // Format: 0123456789 -> 0123 456 789
    if (cleaned.length == 10) {
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 7)} ${cleaned.substring(7)}';
    }

    // Format: 0123456789012 -> 0123 456 789 012
    return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 7)} ${cleaned.substring(7, 10)} ${cleaned.substring(10)}';
  }

  /// Format ID card (CMND/CCCD)
  static String formatIDCard(String idCard) {
    final cleaned = idCard.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length != 9 && cleaned.length != 12) return idCard;

    if (cleaned.length == 9) {
      // CMND: 123456789 -> 123 456 789
      return '${cleaned.substring(0, 3)} ${cleaned.substring(3, 6)} ${cleaned.substring(6)}';
    } else {
      // CCCD: 123456789012 -> 123 456 789 012
      return '${cleaned.substring(0, 3)} ${cleaned.substring(3, 6)} ${cleaned.substring(6, 9)} ${cleaned.substring(9)}';
    }
  }

  // UTILITY FORMATTERS

  /// Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  /// Format percentage
  static String formatPercentage(double value, {int decimalDigits = 1}) {
    final formatter = NumberFormat('#0.${'0' * decimalDigits}%');
    return formatter.format(value / 100);
  }

  /// Format number with unit
  static String formatWithUnit(double value, String unit) {
    return '${formatNumber(value)} $unit';
  }

  /// Format distance (km, m)
  static String formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toStringAsFixed(0)} m';
    } else {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    }
  }

  /// Format duration (hours, minutes, seconds)
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }
}
