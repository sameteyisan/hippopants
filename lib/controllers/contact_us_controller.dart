import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/auth_controller.dart';
import 'package:hippopants/models/contact_us_model.dart';
import 'package:hippopants/utils/helpers.dart';

class ContactUsController extends GetxController {
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void onClose() {
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }

  String? isValid() {
    if (subjectController.text.trim().length < 3) return "subject_very_short_state_subject_better";
    if (messageController.text.trim().length < 5) return "message_very_short_give_more_details";

    return null;
  }

  void sendMessage() async {
    final error = isValid();
    if (error != null) {
      Helpers.showToast(error);
      return;
    }

    EasyLoading.show(maskType: EasyLoadingMaskType.clear);

    final contact = ContactUsModel(
      name: AuthController.to.getFullName,
      email: AuthController.to.getEmail,
      subject: subjectController.text.trim(),
      message: messageController.text.trim(),
    );

    await Future.delayed(300.milliseconds);
    EasyLoading.dismiss();

    Get.back();
    Helpers.showToast("we_received_your_message_get back_as_soon_as");
  }
}
