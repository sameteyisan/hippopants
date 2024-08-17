import 'package:get/get.dart';

class SignUpController extends GetxController {
  final terms = false.obs;
  final electronicMessages = false.obs;

  void setTerms(bool? value) {
    terms.value = value ?? terms.value;
  }

  void setElectronicMessages(bool? value) {
    electronicMessages.value = value ?? electronicMessages.value;
  }
}
