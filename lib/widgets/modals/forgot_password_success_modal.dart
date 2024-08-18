import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordSuccessModal extends StatelessWidget {
  const ForgotPasswordSuccessModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      title: Text(
        "password_reset_email_sent".tr,
      ),
      content: Text(
        "password_reset_email_has_been_sent".tr,
      ),
      actions: [
        FilledButton(
          onPressed: Get.back,
          child: Text("ok".tr),
        )
      ],
    );
  }
}
