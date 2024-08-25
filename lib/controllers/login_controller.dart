import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/auth_controller.dart';
import 'package:hippopants/controllers/navbar_controller.dart';
import 'package:hippopants/screens/forgot_password_screen.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/helpers.dart';
import 'package:hippopants/widgets/modals/forgot_password_success_modal.dart';

class LoginController extends GetxController {
  final obscure = true.obs;

  Map<String, ValidEditingController> validators = {
    "username_or_email": ValidEditingController(
      validFn: (txt) {
        if (GetUtils.isEmail((txt ?? "").trim())) {
          return null;
        } else if (GetUtils.isLengthBetween(txt?.trim(), 3, 16)) {
          return null;
        }

        return "enter_valid_username_or_email_address";
      },
    ),
    "password": ValidEditingController(
      validFn: (txt) {
        if (!GetUtils.isLengthBetween(txt?.trim(), 6, 18)) {
          return "password_entered_must_least_6_most_18_characters";
        }
        return null;
      },
    ),
  };

  @override
  void onClose() {
    for (final validator in validators.values) {
      validator.dispose();
    }
    super.onClose();
  }

  void forgotPassword() async {
    final value = await Get.to(const ForgotPasswordScreen());

    if (value != null) {
      Get.dialog(const ForgotPasswordSuccessModal());
    }
  }

  String? isValid() {
    for (final validator in validators.values) {
      final err = validator.validFn(validator.controller.text);
      if (err != null) return err;
    }

    return null;
  }

  void login() async {
    final error = isValid();
    if (error != null) {
      Helpers.showToast(error);
      return;
    }

    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    await Future.delayed(200.milliseconds);

    AuthController.to.profile.value = Const.USER;
    NavbarController.to.changePage(0);

    EasyLoading.dismiss();
  }
}
