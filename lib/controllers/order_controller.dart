import 'package:get/get.dart';
import 'package:hippopants/models/address/address_model.dart';
import 'package:hippopants/screens/address/add_address_screen.dart';
import 'package:hippopants/screens/address/addresses_screen.dart';
import 'package:hippopants/utils/const.dart';

class OrderController extends GetxController {
  final isLoading = true.obs;

  final deliveryAddress = Rxn<AddressModel>();

  @override
  void onInit() async {
    await Future.delayed(300.milliseconds);
    deliveryAddress.value = Const.ADDRESSES[0];

    isLoading.value = false;
    super.onInit();
  }

  void addAddress({AddressModel? addressModel}) async {
    final AddressModel? address = await Get.to(AddAddressScreen(addressModel: addressModel));

    if (address != null) {
      // AddressesController.to.addresses.insert(0, address);
      deliveryAddress.value = address;
    }
  }

  void addOrEditAddress() async {
    final AddressModel? address =
        await Get.to(AddressesScreen(selectedAddressID: deliveryAddress.value?.id));
    if (address == null) return;

    deliveryAddress.value = address;
  }
}
