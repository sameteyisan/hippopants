import 'package:intl/intl.dart';

extension CurrencyFormatting on double {
  String get toCurrency {
    final format = NumberFormat.currency(
      locale: "tr_TR",
      symbol: "₺",
      decimalDigits: 2,
    );
    return format.format(this);
  }

  double get fract => this - floor();
}

extension StringX on String {
  String get turkishCapitalize {
    if (isEmpty) return "";
    return this[0].toUpperCaseTurkish() + substring(1).toLowerCaseTurkish();
  }

  String get turkishTitleCase {
    if (isEmpty) return "";
    return trim()
        .replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.turkishCapitalize)
        .join(' ');
  }

  String toLowerCaseTurkish() {
    return replaceAll('I', 'ı').replaceAll('İ', 'i').toLowerCase();
  }

  String toUpperCaseTurkish() {
    return replaceAll('i', 'İ').replaceAll('ı', 'I').toUpperCase();
  }
}
