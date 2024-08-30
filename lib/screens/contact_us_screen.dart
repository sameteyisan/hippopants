import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/auth_controller.dart';
import 'package:hippopants/controllers/contact_us_controller.dart';
import 'package:hippopants/widgets/custom/text_field.dart';
import 'package:hippopants/widgets/empty_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ContactUsController());

    return Scaffold(
      appBar: AppBar(
        title: Text("contact_us".tr),
      ),
      body: AuthController.to.profile.value != null
          ? ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CustomTextField(
                  labelText: "subject",
                  controller: controller.subjectController,
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  labelText: "your_message",
                  controller: controller.messageController,
                  minLines: 3,
                  maxLines: 4,
                ),
                const SizedBox(height: 32),
                FilledButton(
                  onPressed: controller.sendMessage,
                  child: Text("send".tr),
                ),
              ],
            )
          : EmptyWidget(text: "this_contact_form_only_logged_users".tr),
    );
  }
}
