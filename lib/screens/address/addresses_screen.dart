import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/address/addresses_controller.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/empty_widget.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressesController());

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
                      ...controller.addresses.map((address) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: InkWell(
                              onTap: () => controller.editAddress(address),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: CColors.foregroundColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            address.fullname,
                                            style: Styles.bold.copyWith(fontSize: 17),
                                          ),
                                        ),
                                        if (address.byDefault) const Icon(Icons.check),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      address.address,
                                      style: Styles.normal,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      address.cityCounty,
                                      style: Styles.normal,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      const SizedBox(height: 120),
                    ],
                  ),
      ),
    );
  }
}
