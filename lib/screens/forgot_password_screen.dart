import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/custom/text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Şifremi Unuttum"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Image.asset(
              Const.LOGO,
              width: Get.width * 0.5,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            "forgot_password_please_enter".tr,
            style: Styles.normal,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const CustomTextField(labelText: "username_or_eposta"),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: Get.back,
            child: Text("reset_my_password".tr),
          ),
        ],
      ),
    );
  }
}
