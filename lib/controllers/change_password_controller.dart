import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/helpers.dart';

class ChangePasswordController extends GetxController {
  final obscure = true.obs;

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPasswordAgainController = TextEditingController();

  String? oldPassord;
  ChangePasswordController(this.oldPassord);

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    newPasswordAgainController.dispose();
    super.onClose();
  }

  String? isValid() {
    final old = oldPasswordController.text.trim();
    final newP = newPasswordController.text.trim();
    final newPA = newPasswordAgainController.text.trim();

    if (old != oldPassord) return "you_entered_old_password_incorrectly";
    if (newP.length < 6) return "password_entered_must_least_6_most_18_characters";
    if (newP != newPA) return "passwords_entered_dont_match";

    return null;
  }

  void changePassword() async {
    final error = isValid();
    if (error != null) {
      Helpers.showToast(error);
      return;
    }

    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    await Future.delayed(200.milliseconds);
    EasyLoading.dismiss();

    Get.back();
    Helpers.showToast("your_password_changed");
  }
}
