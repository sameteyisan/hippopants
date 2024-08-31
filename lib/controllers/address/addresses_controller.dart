import 'package:get/get.dart';
import 'package:hippopants/models/address/address_model.dart';
import 'package:hippopants/screens/address/add_address_screen.dart';
import 'package:hippopants/utils/const.dart';

class AddressesController extends GetxController {
  static AddressesController get to => Get.find();

  final selectedID = Rxn<int>();

  final isLoading = true.obs;

  final addresses = <AddressModel>[].obs;

  int? selectedAddressID;
  AddressesController(this.selectedAddressID);

  @override
  void onInit() async {
    await Future.delayed(300.milliseconds);
    addresses.addAll(Const.ADDRESSES);

    isLoading.value = false;

    selectedID.value = selectedAddressID;
    super.onInit();
  }

  void addAddress() async {
    final AddressModel? address = await Get.to(AddAddressScreen(
      availableAddressesCount: addresses.length,
    ));
    if (address == null) return;

    addresses.insert(0, address);
  }

  void editAddress(AddressModel address) async {
    final AddressModel? updatedAddress = await Get.to(AddAddressScreen(
      availableAddressesCount: addresses.length,
      addressModel: address,
    ));
    if (updatedAddress == null) return;

    final idx = addresses.indexWhere((e) => e.id == address.id);
    if (idx != -1) {
      addresses[idx] = updatedAddress;
      addresses.refresh();
    }
  }
}
