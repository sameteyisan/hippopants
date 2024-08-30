import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/product_details_controller.dart';
import 'package:hippopants/models/product/mini_product_model.dart';
import 'package:hippopants/screens/review_product_screen.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/page_indicator.dart';

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
                  () => controller.isLoading.value
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
                              () => Row(
                                children: controller.product.value!.sizes.map((e) {
                                  final selected = controller.selectedSize.value == e;
                                  final isAvailable =
                                      controller.product.value!.availableSizes.contains(e.size);

                                  return AnimatedOpacity(
                                    duration: 200.milliseconds,
                                    opacity: isAvailable ? 1 : 0.3,
                                    child: GestureDetector(
                                      onTap: () => controller.setSize(e),
                                      child: AnimatedContainer(
                                        duration: 200.milliseconds,
                                        alignment: Alignment.center,
                                        width: 40,
                                        height: 40,
                                        margin: const EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.black.withOpacity(selected ? 1 : 0.4),
                                          ),
                                        ),
                                        child: Text(
                                          e.size,
                                          style: selected ? Styles.bold : Styles.normal,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(() {
                              final size = controller.selectedSize.value;
                              if (size == null) return const SizedBox();

                              return Text(
                                "Beden: ${size.size}  (Son ${size.quantity} ürün)",
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
