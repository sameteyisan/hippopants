import 'package:intl/intl.dart';

class ModelParsers {
  static String dateTo(DateTime date) {
    // final now = DateTime.now();
    // final duration = date.difference(now);
    // if (duration.inDays == 0) {
    //   return "today".tr;
    // } else if (duration.inDays == -1) {
    //   return "yesterday".tr;
    // }

    final formatter = DateFormat("dd MMMM yyyy");
    return formatter.format(date);
  }
}
