import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/order_controller.dart';
import 'package:hippopants/widgets/address_card.dart';
import 'package:hippopants/widgets/center_loading.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

    return Scaffold(
      appBar: AppBar(
        title: Text("complete_the_order".tr),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const CenterLoading()
            : ListView(
                children: [
                  if (controller.deliveryAddress.value != null)
                    AddressCard(
                      address: controller.deliveryAddress.value!,
                      more: TextButton(
                        onPressed: controller.addOrEditAddress,
                        child: Text("${"add".tr} / ${"edit".tr}"),
                      ),
                    )
                  else
                    EmptyAddressCard(
                      onTap: controller.addAddress,
                    ),
                  const SizedBox(height: 16),
                ],
              ),
      ),
    );
  }
}
