import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/login_controller.dart';
import 'package:hippopants/screens/sign_up_screen.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/custom/text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          "log_in".tr,
          style: Styles.big,
        ),
        const SizedBox(height: 32),
        CustomTextField(
          labelText: "username_or_email",
          controller: controller.validators["username_or_email"]!.controller,
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
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: controller.forgotPassword,
            child: Text("forgot_your_password".tr),
          ),
        ),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: controller.login,
          child: Text("log_in".tr),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Get.to(const SignUpScreen()),
          child: Text("sign_up".tr),
        )
      ],
    );
  }
}
