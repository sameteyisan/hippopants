import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/change_password_controller.dart';
import 'package:hippopants/widgets/custom/text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key, required this.oldPassword});
  final String oldPassword;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController(oldPassword));

    return Scaffold(
      appBar: AppBar(
        title: Text("change_password".tr),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomTextField(
            labelText: "old_password",
            controller: controller.oldPasswordController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            labelText: "new_password",
            controller: controller.newPasswordController,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            labelText: "new_password_again",
            controller: controller.newPasswordAgainController,
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: controller.changePassword,
            child: Text("change_password".tr),
          )
        ],
      ),
    );
  }
}
