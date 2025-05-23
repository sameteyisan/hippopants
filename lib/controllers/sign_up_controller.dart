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
    "username": ValidEditingController(
      validFn: (txt) {
        if (GetUtils.isLengthBetween(txt?.trim(), 3, 16)) {
          return "enter_valid_username";
        }

        return null;
      },
    ),
    "email": ValidEditingController(
      validFn: (txt) {
        if (GetUtils.isEmail((txt ?? "").trim())) {
          return "enter_valid_email";
        }

        return null;
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
      return "you_must_accept_terms_and_privacy_policies";
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
      id: -1,
      name: validators["name"]!.controller.text.trim(),
      surname: validators["surname"]!.controller.text.trim(),
      username: validators["username"]!.controller.text.trim(),
      email: validators["email"]!.controller.text.trim(),
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

  @override
  void onClose() {
    for (final validator in validators.values) {
      validator.dispose();
    }
    super.onClose();
  }
}
