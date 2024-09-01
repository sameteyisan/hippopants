import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/add_basket_controller.dart';
import 'package:hippopants/models/product/mini_product_model.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/discounted_price_widget.dart';
import 'package:hippopants/widgets/quantity_changer.dart';
import 'package:hippopants/widgets/sale_widget.dart';
import 'package:hippopants/widgets/size_changer.dart';

class AddBasketSheet extends StatelessWidget {
  const AddBasketSheet({super.key, required this.miniProduct});
  final MiniProductModel miniProduct;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddBasketController(miniProduct));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: miniProduct.images
                    .map(
                      (image) => Image.asset(
                        image,
                        width: Get.width * 0.5,
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    miniProduct.name,
                    style: Styles.bold.copyWith(fontSize: 19),
                  ),
                ),
                const SizedBox(width: 16),
                if (miniProduct.discountPrice != null) const SaleWidget(),
              ],
            ),
            const SizedBox(height: 8),
            DiscountedPriceWidget(
              price: miniProduct.price,
              discountPrice: miniProduct.discountPrice,
              horizontal: true,
            ),
            const SizedBox(height: 24),
            Obx(
              () => controller.isLoading.value || controller.product.value == null
                  ? const CenterLoading()
                  : SizeChanger(
                      product: controller.product.value!,
                      onChanged: (size) => controller.selectedSize.value = size,
                    ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              final size = controller.selectedSize.value;
              if (size == null) return const SizedBox();

              return Text(size.getText);
            }),
            const SizedBox(height: 8),
            Obx(() {
              final max = controller.selectedSize.value != null &&
                      controller.selectedSize.value!.quantity < 5
                  ? controller.selectedSize.value!.quantity
                  : null;

              return QuantityChanger(
                quantity: controller.quantity.value,
                onChanged: (value) => controller.quantity.value = value,
                max: max,
                size: 38,
                iconSize: 24,
              );
            }),
            const SizedBox(height: 32),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
              ),
              onPressed: controller.addToBasket,
              icon: const Icon(Icons.shopping_basket),
              label: Text("add_to_basket".tr),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static void show(MiniProductModel miniProduct) async => await Get.bottomSheet(
        AddBasketSheet(miniProduct: miniProduct),
      );
}
