import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/orders_controller.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/model_parsers.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/empty_widget.dart';
import 'package:hippopants/widgets/order_rich.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrdersController());

    return Scaffold(
      appBar: AppBar(
        title: Text("my_orders".tr),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const CenterLoading()
            : controller.orders.isEmpty
                ? const EmptyWidget(text: "you_have_not_ordered_yet_start_shopping_now")
                : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    children: controller.orders.map((order) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: CColors.foregroundColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OrderRich(
                                      normal: "order_number".tr,
                                      bold: "#${order.number}",
                                    ),
                                    const SizedBox(height: 4),
                                    OrderRich(
                                      normal: "order_date".tr,
                                      bold: ModelParsers.dateTo(order.date),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Detaylar"),
                                        Icon(Icons.chevron_right),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 64,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: order.products
                                    .map(
                                      (product) => Container(
                                        width: 64,
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          image: DecorationImage(
                                            image: AssetImage(product.image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "value_products_status".trParams({
                                    "value": order.count.toString(),
                                    "status": order.status.name.tr.toLowerCase(),
                                  }),
                                ),
                                const Spacer(),
                                Text(
                                  order.price.toCurrency,
                                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
      ),
    );
  }
}
