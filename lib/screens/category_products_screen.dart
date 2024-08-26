import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/category_products_controller.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/empty_widget.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryProductsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Women"),
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
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 250,
                    ),
                    children: controller.products
                        .map((product) => Container(
                              padding: const EdgeInsets.only(top: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: CColors.foregroundColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Image.asset(
                                      product.image,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      product.name,
                                      style: Styles.bold.copyWith(fontSize: 17),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                                    child: Text(
                                      product.price.toCurrency,
                                      style: Styles.bold.copyWith(fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList()),
      ),
    );
  }
}
