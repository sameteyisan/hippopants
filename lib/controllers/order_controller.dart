import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:hippopants/models/address/address_model.dart';
import 'package:hippopants/screens/address/add_address_screen.dart';
import 'package:hippopants/screens/address/addresses_screen.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/helpers.dart';
import 'package:hippopants/widgets/modals/animation_modal.dart';
import 'package:hippopants/widgets/sheets/credit_card_expirt_sheet.dart';

class OrderController extends GetxController {
  final isLoading = true.obs;

  final terms = false.obs;
  final showItems = false.obs;
  final showBackView = false.obs;

  final pricingValue = 0.0.obs;

  final cvvFocus = FocusNode();

  final deliveryAddress = Rxn<AddressModel>();

  final expiryDateController = TextEditingController();
  final cardNumberController = MaskedTextController(mask: '0000 0000 0000 0000');

  final cvvCode = "".obs;
  final expiryDate = "".obs;

  final cardNumber = "".obs;
  final cardHolderName = "".obs;

  DateTime expiryDateTime = DateTime.now();

  bool get showPricing => pricingValue.value.fract != 0;

  @override
  void onInit() async {
    await Future.delayed(300.milliseconds);
    deliveryAddress.value = Const.ADDRESSES[0];

    isLoading.value = false;

    cvvFocus.addListener(cvvListener);
    super.onInit();
  }

  void cvvListener() {
    showBackView.value = cvvFocus.hasFocus;
  }

  void setTerms(bool? value) {
    terms.value = value ?? terms.value;
  }

  void setExpiryDate(BuildContext context) async {
    final DateTime? date = await CreditCardExpirySheet.open(expiryDateTime);
    if (date == null) return;

    expiryDateTime = date;

    expiryDate.value =
        "${date.month.toString().padLeft(2, "0")}/${date.year.toString().substring(2)}";

    expiryDateController.text = expiryDate.value;
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

  String? isValid() {
    if (deliveryAddress.value == null) {
      return "please_select_delivery_address_before_completing_the_order";
    }

    if (cardHolderName.value.isEmpty ||
        cardNumber.value.length != 19 ||
        expiryDate.value.isEmpty ||
        cvvCode.value.length != 3) {
      return "check_the_card_information_and_try_again";
    }

    if (!terms.value) {
      return "you_must_approve_prior_information_terms_conditions_distance_sales_agreement";
    }

    return null;
  }

  Future<void> completeOrder() async {
    final error = isValid();
    if (error != null) {
      Helpers.showToast(error);
      return;
    }

    AnimationModal.show("the_order_is_being_completed");
    await Future.delayed(1000.milliseconds);
    Get.back();
  }

  @override
  void onClose() {
    cvvFocus.removeListener(cvvListener);
    cvvFocus.dispose();

    cardNumberController.dispose();
    expiryDateController.dispose();
    super.onClose();
  }
}
