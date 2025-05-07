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

  static bool isValidPostCode(String postcode) {
    final regex = RegExp(r'^\d{5}$');
    return regex.hasMatch(postcode);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    final regex = RegExp(r'^(5\d{9})$');
    return regex.hasMatch(phoneNumber);
  }

  static bool isValidCVC(String cvc) {
    final regex = RegExp(r'^\d{3}$');
    return regex.hasMatch(cvc);
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
    }
  }

  static bool hasController<T>([String? tag]) {
    try {
      Get.find<T>(tag: tag);
      return true;
    } catch (_) {
      return false;
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
