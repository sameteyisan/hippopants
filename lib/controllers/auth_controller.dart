import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/login_controller.dart';
import 'package:hippopants/models/profile_model.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final profile = Rxn<ProfileModel>();

  String get getFullName => profile.value?.fullname ?? "";
  String get getUsername => profile.value?.username ?? "";
  String get getEmail => profile.value?.email ?? "";

  @override
  void onInit() {
    ever(profile, (prf) {
      if (prf != null) Get.delete<LoginController>();
    });
    super.onInit();
  }

  void signOut() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    await Future.delayed(200.milliseconds);
    EasyLoading.dismiss();

    profile.value = null;
  }
}
