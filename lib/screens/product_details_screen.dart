import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/product_details_controller.dart';
import 'package:hippopants/models/product/mini_product_model.dart';
import 'package:hippopants/screens/review_product_screen.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/discounted_price_widget.dart';
import 'package:hippopants/widgets/page_indicator.dart';
import 'package:hippopants/widgets/quantity_changer.dart';
import 'package:hippopants/widgets/sale_widget.dart';
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        miniProduct.name,
                        style: Styles.big,
                      ),
                    ),
                    if (miniProduct.discountPrice != null) const SaleWidget(),
                  ],
                ),
                const SizedBox(height: 8),
                DiscountedPriceWidget(
                  price: miniProduct.price,
                  discountPrice: miniProduct.discountPrice,
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
                                onChanged: controller.setSize,
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
