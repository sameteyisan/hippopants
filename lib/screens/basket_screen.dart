import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/basket_controller.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/empty_widget.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BasketController());

    return Obx(
      () => controller.isLoading.value
          ? const CenterLoading()
          : const EmptyWidget(text: "Sepetinizde ürün bulunmamaktadır."),
    );
  }
}
