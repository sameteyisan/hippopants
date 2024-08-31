import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/product_details_controller.dart';
import 'package:hippopants/models/product/mini_product_model.dart';
import 'package:hippopants/screens/review_product_screen.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/page_indicator.dart';
import 'package:hippopants/widgets/size_changer.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.miniProduct});
  final MiniProductModel miniProduct;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController(miniProduct));

    return Scaffold(
      appBar: AppBar(
        title: Text(miniProduct.name),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Container(
            height: 300,
            color: CColors.foregroundColor,
            child: Column(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.to(
                      ReviewProductScreen(
                        images: miniProduct.images,
                        initialIndex: controller.currentPageIndex.value,
                        title: miniProduct.name,
                      ),
                    ),
                    child: PageView(
                      onPageChanged: (value) => controller.currentPageIndex.value = value,
                      children: miniProduct.images.map((image) => Image.asset(image)).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: miniProduct.images.indexed
                          .map((e) =>
                              PageIndicator(selected: e.$1 == controller.currentPageIndex.value))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  miniProduct.name,
                  style: Styles.big,
                ),
                const SizedBox(height: 8),
                Text(
                  miniProduct.price.toCurrency,
                  style: Styles.big,
                ),
                const SizedBox(height: 16),
                Obx(
                  () => controller.isLoading.value || controller.product.value == null
                      ? const CenterLoading()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.product.value?.description ?? "",
                              style: Styles.normal,
                            ),
                            const SizedBox(height: 16),
                            Obx(
                              () => SizeChanger(
                                product: controller.product.value!,
                                onChanged: (size) => controller.selectedSize.value = size,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(() {
                              final size = controller.selectedSize.value;
                              if (size == null) return const SizedBox();

                              return Text(
                                "${"size".tr}: ${size.size}  ${size.quantity <= 10 ? (size.quantity > 1 ? "last_val_product" : "last_val_products").trParams({
                                        "val": size.quantity.toString()
                                      }) : ""}",
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
