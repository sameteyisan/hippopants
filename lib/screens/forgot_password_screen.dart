import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/helpers.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/custom/text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController? textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController?.dispose();
    super.dispose();
  }

  String? isValid() {
    final txt = textEditingController?.text.trim();

    if (GetUtils.isEmail(txt ?? "")) {
      return null;
    } else if (GetUtils.isLengthBetween(txt?.trim(), 3, 16)) {
      return null;
    }

    return "enter_valid_username_or_email_address";
  }

  void resetPassword() async {
    final error = isValid();
    if (error != null) {
      Helpers.showToast(error);
      return;
    }

    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    await Future.delayed(200.milliseconds);
    EasyLoading.dismiss();

    Get.back(result: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("forgot_password".tr),
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
          CustomTextField(
            labelText: "username_or_email",
            controller: textEditingController,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: resetPassword,
            child: Text("reset_my_password".tr),
          ),
        ],
      ),
    );
  }
}
