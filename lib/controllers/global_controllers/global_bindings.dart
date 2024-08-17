import 'package:get/get.dart';
import 'package:hippopants/controllers/global_controllers/global_controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController());
  }

  static void resetProfileControllers({required bool isLogin, bool isAnonymous = false}) {}
}
