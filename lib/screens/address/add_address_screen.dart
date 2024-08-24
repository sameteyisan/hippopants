import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/address/add_address_controller.dart';
import 'package:hippopants/widgets/custom/text_field.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddAddressController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),
          CustomTextField(
            labelText: "City",
            controller: controller.validators["city"]!.controller,
            readOnly: true,
            onTap: controller.changeCity,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            labelText: "County",
            controller: controller.validators["county"]!.controller,
            readOnly: true,
            onTap: controller.changeCounty,
          ),
        ],
      ),
    );
  }
}
