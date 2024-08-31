import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/address/addresses_controller.dart';
import 'package:hippopants/widgets/address_card.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/empty_widget.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key, this.selectedAddressID});
  final int? selectedAddressID;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressesController(selectedAddressID));

    return Scaffold(
      appBar: AppBar(
        title: Text("my_addresses".tr),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: controller.addAddress,
          icon: const Icon(Icons.add),
          label: Text("add_address".tr),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const CenterLoading()
            : controller.addresses.isEmpty
                ? const EmptyWidget(text: "you_havent_added_an_address_yet")
                : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: [
                      ...controller.addresses.map((address) {
                        final selected = controller.selectedID.value == address.id;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () => controller.selectedID.value = address.id,
                                child: AddressCard(
                                  address: address,
                                  onEdited: () => controller.editAddress(address),
                                  more: address.byDefault ? const Icon(Icons.check) : null,
                                  selected: selected,
                                ),
                              ),
                              if (selected)
                                TextButton(
                                  onPressed: () => Get.back(result: address),
                                  child: Text("use_this_address".tr),
                                ),
                            ],
                          ),
                        );
                      }),
                      const SizedBox(height: 120),
                    ],
                  ),
      ),
    );
  }
}
