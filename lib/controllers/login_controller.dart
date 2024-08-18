import 'package:get/get.dart';
import 'package:hippopants/screens/forgot_password_screen.dart';
import 'package:hippopants/widgets/modals/forgot_password_success_modal.dart';

class LoginController extends GetxController {
  void forgotPassword() async {
    final value = await Get.to(const ForgotPasswordScreen());

    if (value != null) {
      Get.dialog(const ForgotPasswordSuccessModal());
    }
  }
}
