import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/auth_controller.dart';
import 'package:hippopants/models/profile_model.dart';
import 'package:hippopants/utils/helpers.dart';

class SignUpController extends GetxController {
  final obscure = true.obs;

  final terms = false.obs;
  final electronicMessages = false.obs;

  Map<String, ValidEditingController> validators = {
    "name": ValidEditingController(
      validFn: (txt) {
        if (!GetUtils.isLengthGreaterOrEqual(txt?.trim(), 3)) {
          return "name_entered_must_least_3_characters";
        }
        return null;
      },
    ),
    "surname": ValidEditingController(
      validFn: (txt) {
        if (!GetUtils.isLengthGreaterOrEqual(txt?.trim(), 2)) {
          return "surname_entered_must_least_2_characters";
        }
        return null;
      },
    ),
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

  void setTerms(bool? value) {
    terms.value = value ?? terms.value;
  }

  void setElectronicMessages(bool? value) {
    electronicMessages.value = value ?? electronicMessages.value;
  }

  String? isValid() {
    for (final validator in validators.values) {
      final err = validator.validFn(validator.controller.text);
      if (err != null) return err;
    }

    if (!terms.value) {
      return "Üyelik koşullarını ve gizlilik ve güvenlik ilkelerini kabul etmeniz gerekmektedir.";
    }

    return null;
  }

  void signUp() async {
    final error = isValid();
    if (error != null) {
      Helpers.showToast(error);
      return;
    }

    final profile = ProfileModel(
      name: validators["name"]!.controller.text.trim(),
      surname: validators["surname"]!.controller.text.trim(),
      usernameOrEmail: validators["username_or_email"]!.controller.text.trim(),
      password: validators["password"]!.controller.text.trim(),
      electronicMessages: electronicMessages.value,
    );

    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    await Future.delayed(200.milliseconds);
    AuthController.to.profile.value = profile;
    EasyLoading.dismiss();

    Get.back();
    Helpers.showToast("welcome_hippopants_family".tr);
  }
}
