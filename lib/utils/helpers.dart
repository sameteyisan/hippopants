import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Helpers {
  static Future<void> showToast(String msg) async {
    return await EasyLoading.showError(
      msg.tr,
    );
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
