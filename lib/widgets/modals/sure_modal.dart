import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SureModal extends StatelessWidget {
  const SureModal({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      title: Text("are_you_sure".tr),
      content: Text(text.tr),
      actions: [
        FilledButton(
          onPressed: Get.back,
          child: Text("cancel".tr),
        ),
        FilledButton(
          onPressed: () => Get.back(result: true),
          child: Text("delete".tr),
        )
      ],
    );
  }

  static Future<bool?> show(String text) async => await Get.dialog(SureModal(text: text));
}
