import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/const.dart';

class Helpers {
  static Future<void> showToast(String msg) async {
    return await EasyLoading.showError(
      msg.tr,
    );
  }

  static Widget orderStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.Pending:
        return const Icon(Icons.abc);
      case OrderStatus.Preparing:
        return const Icon(Icons.abc);
      case OrderStatus.OnTheWay:
        return const Icon(Icons.abc);
      case OrderStatus.Delivered:
        return const Icon(Icons.abc);
      case OrderStatus.Cancelled:
        return const Icon(Icons.abc);
      default:
        return const SizedBox();
    }
  }

  static Color orderStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.Pending:
        return Colors.orange;
      case OrderStatus.Preparing:
        return Colors.teal;
      case OrderStatus.OnTheWay:
        return Colors.blue;
      case OrderStatus.Delivered:
        return Colors.green;
      case OrderStatus.Cancelled:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

class ValidEditingController {
  TextEditingController controller = TextEditingController();
  String? Function(String? txt) validFn;
  ValidEditingController({
    required this.validFn,
  });

  void dispose() => controller.dispose();
}
