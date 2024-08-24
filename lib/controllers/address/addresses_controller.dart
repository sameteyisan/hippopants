import 'package:get/get.dart';
import 'package:hippopants/screens/address/add_address_screen.dart';

class AddressesController extends GetxController {
  @override
  void onReady() {
    Get.to(const AddAddressScreen());
    super.onReady();
  }
}
