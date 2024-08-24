import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/auth_controller.dart';
import 'package:hippopants/screens/change_password_screen.dart';
import 'package:hippopants/utils/helpers.dart';

class AccountDetailsController extends GetxController {
  final electronicMessages = false.obs;

  Map<String, ValidEditingController> validators = {
    "name": ValidEditingController(
      validFn: (txt) {
        if (!GetUtils.isLengthBetween(txt?.trim(), 3, 16)) {
          return "name_entered_must_least_3_characters";
        }

        return null;
      },
    ),
    "surname": ValidEditingController(
      validFn: (txt) {
        if (!GetUtils.isLengthBetween(txt?.trim(), 3, 16)) {
          return "surname_entered_must_least_2_characters";
        }

        return null;
      },
    ),
    "display_name": ValidEditingController(
      validFn: (txt) {
        if (!GetUtils.isLengthBetween(txt?.trim(), 3, 16)) {
          return "display_name_must_least_3_characters";
        }

        return null;
      },
    ),
    "username": ValidEditingController(
      validFn: (txt) {
        if (!GetUtils.isEmail((txt ?? "").trim())) {
          return "enter_valid_email";
        }

        return null;
      },
    ),
    "email": ValidEditingController(
      validFn: (txt) {
        if (!GetUtils.isEmail((txt ?? "").trim())) {
          return "enter_valid_email";
        }

        return null;
      },
    ),
  };

  @override
  void onInit() {
    setFields();
    super.onInit();
  }

  void setFields() {
    final profile = AuthController.to.profile.value!;

    validators["name"]!.controller.text = profile.name;
    validators["surname"]!.controller.text = profile.surname;
    validators["display_name"]!.controller.text = profile.username;
    validators["username"]!.controller.text = profile.username;
    validators["email"]!.controller.text = profile.email;

    electronicMessages.value = profile.electronicMessages;
  }

  void setElectronicMessages(bool? value) {
    electronicMessages.value = value ?? electronicMessages.value;
  }

  String? isValid() {
    for (final validator in validators.values) {
      final err = validator.validFn(validator.controller.text);
      if (err != null) return err;
    }

    return null;
  }

  void changePassword() {
    Get.to(ChangePasswordScreen(oldPassword: AuthController.to.profile.value!.password));
  }

  void save() async {
    final error = isValid();
    if (error != null) {
      Helpers.showToast(error);
      return;
    }

    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    await Future.delayed(200.milliseconds);
    AuthController.to.profile.value = AuthController.to.profile.value?.copyWith(
      name: validators["name"]!.controller.text.trim(),
      surname: validators["surname"]!.controller.text.trim(),
      username: validators["username"]!.controller.text.trim(),
      email: validators["email"]!.controller.text.trim(),
      electronicMessages: electronicMessages.value,
    );

    EasyLoading.dismiss();
    Get.back();
  }
}
