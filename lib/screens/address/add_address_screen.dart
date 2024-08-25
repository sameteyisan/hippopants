import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/address/add_address_controller.dart';
import 'package:hippopants/controllers/address/addresses_controller.dart';
import 'package:hippopants/models/address/address_model.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/custom/checkbox_tile_widget.dart';
import 'package:hippopants/widgets/custom/text_field.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key, this.addressModel});
  final AddressModel? addressModel;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddAddressController(addressModel));

    return Scaffold(
      appBar: AppBar(
        title: Text(addressModel != null ? "update_address".tr : "add_address".tr),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CustomTextField(
              labelText: "name",
              controller: controller.validators["name"]!.controller,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: "surname",
              controller: controller.validators["surname"]!.controller,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: "city",
              controller: controller.validators["city"]!.controller,
              readOnly: true,
              onTap: controller.changeCity,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: "county",
              controller: controller.validators["county"]!.controller,
              readOnly: true,
              onTap: controller.changeCounty,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: "address",
              controller: controller.validators["address"]!.controller,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: "postcode",
              controller: controller.validators["postcode"]!.controller,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: "phone",
              controller: controller.phoneController,
            ),
            if (AddressesController.to.addresses.length > 1)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Obx(
                  () => CheckboxTileWidget(
                    value: controller.byDefault.value,
                    onChanged: controller.setByDefault,
                    child: Text(
                      "set_as_default_address".tr,
                      style: Styles.normal,
                    ),
                  ),
                ),
              ),
            if (addressModel != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: TextButton(
                  onPressed: () => controller.deleteAddress(addressModel!.id),
                  child: Text(
                    "delete_address".tr,
                    style: TextStyle(
                      color: CColors.red,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: controller.addAddress,
              child: Text(addressModel != null ? "update_address".tr : "add_address".tr),
            ),
          ],
        ),
      ),
    );
  }
}
