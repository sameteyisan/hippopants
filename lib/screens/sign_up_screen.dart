import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/sign_up_controller.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/custom/checkbox_tile_widget.dart';
import 'package:hippopants/widgets/custom/text_field.dart';
import 'package:hippopants/widgets/highlighted_rich_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      appBar: AppBar(
        title: Text("sign_up".tr),
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
            labelText: "username",
            controller: controller.validators["username"]!.controller,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            labelText: "email",
            controller: controller.validators["email"]!.controller,
          ),
          const SizedBox(height: 16),
          Obx(
            () => CustomTextField(
              labelText: "password",
              controller: controller.validators["password"]!.controller,
              obscureText: controller.obscure.value,
              suffixIcon: IconButton(
                onPressed: controller.obscure.toggle,
                icon: !controller.obscure.value
                    ? const Icon(Icons.visibility_outlined)
                    : const Icon(Icons.visibility_off_outlined),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "your_personal_data_will_be_used_to_support_your_experience".tr,
            style: Styles.normal,
          ),
          const SizedBox(height: 16),
          Obx(
            () => CheckboxTileWidget(
              value: controller.terms.value,
              onChanged: controller.setTerms,
              child: HighlightedRichText(
                splitted: "accept_the_membership_terms ".tr.split("|"),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 32),
          FilledButton(
            onPressed: controller.signUp,
            child: Text("sign_up".tr),
          )
        ],
      ),
    );
  }
}
