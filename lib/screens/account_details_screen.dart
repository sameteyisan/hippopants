import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/account_details_controller.dart';
import 'package:hippopants/controllers/auth_controller.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/custom/checkbox_tile_widget.dart';
import 'package:hippopants/widgets/custom/text_field.dart';

class AccountDetailsScreen extends GetView<AuthController> {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountDetailsController());

    return Scaffold(
      appBar: AppBar(
        title: Text("account_details".tr),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomTextField(
            labelText: "name",
            controller: controller.validators["name"]!.controller,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            labelText: "surname",
            controller: controller.validators["surname"]!.controller,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            labelText: "display_name",
            controller: controller.validators["display_name"]!.controller,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            labelText: "email",
            controller: controller.validators["email"]!.controller,
          ),
          const SizedBox(height: 32),
          Obx(
            () => CheckboxTileWidget(
              value: controller.electronicMessages.value,
              onChanged: controller.setElectronicMessages,
              child: Text(
                "receive_electronic_messages".tr,
                style: Styles.normal,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: controller.changePassword,
            child: Text("change_password".tr),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: controller.save,
            child: Text("save".tr),
          ),
        ],
      ),
    );
  }
}
