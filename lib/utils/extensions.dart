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
}
