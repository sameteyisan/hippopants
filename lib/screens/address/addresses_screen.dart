import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/address/addresses_controller.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressesController());

    return Scaffold(
      appBar: AppBar(
        title: Text("my_addresses".tr),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [],
      ),
    );
  }
}
