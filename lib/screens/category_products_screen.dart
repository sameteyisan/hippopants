import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/category_products_controller.dart';
import 'package:hippopants/screens/product_details_screen.dart';
import 'package:hippopants/widgets/category_product_card.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/empty_widget.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryProductsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kadın"),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const CenterLoading()
            : controller.products.isEmpty
                ? const EmptyWidget(text: "no_product_was_found")
                : GridView(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      mainAxisExtent: 300,
                    ),
                    children: controller.products
                        .map(
                          (product) => CategoryProductCard(
                            product: product,
                            onTap: () => Get.to(
                              ProductDetailsScreen(miniProduct: product),
                            ),
                            onAddedToBasket: () => controller.addToBasket(product),
                          ),
                        )
                        .toList(),
                  ),
      ),
    );
  }
}
