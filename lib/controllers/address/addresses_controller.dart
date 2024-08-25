import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hippopants/models/address/address_model.dart';
import 'package:hippopants/screens/address/add_address_screen.dart';
import 'package:hippopants/utils/const.dart';

class AddressesController extends GetxController {
  static AddressesController get to => Get.find();

  final addresses = <AddressModel>[].obs;

  @override
  void onInit() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);

    await Future.delayed(300.milliseconds);
    addresses.addAll(Const.ADDRESSES);

    EasyLoading.dismiss();
    super.onInit();
  }

  void addAddress() async {
    final AddressModel? address = await Get.to(const AddAddressScreen());
    if (address == null) return;

    addresses.insert(0, address);
  }

  void editAddress(AddressModel address) async {
    final AddressModel? updatedAddress = await Get.to(AddAddressScreen(addressModel: address));
    if (updatedAddress == null) return;
  }
}
