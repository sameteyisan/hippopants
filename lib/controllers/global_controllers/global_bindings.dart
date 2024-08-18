import 'package:get/get.dart';
import 'package:hippopants/controllers/auth_controller.dart';
import 'package:hippopants/controllers/global_controllers/global_controller.dart';
import 'package:hippopants/controllers/navbar_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(GlobalController());
    Get.put(NavbarController());
  }

  static void resetProfileControllers({required bool isLogin, bool isAnonymous = false}) {}
}
