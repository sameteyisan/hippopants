import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/basket_controller.dart';
import 'package:hippopants/controllers/navbar_controller.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/discounted_price_widget.dart';
import 'package:hippopants/widgets/empty_widget.dart';
import 'package:hippopants/widgets/quantity_changer.dart';
import 'package:hippopants/widgets/total_price_and_complete_widget.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BasketController());

    return Obx(
      () => controller.isLoading.value
          ? const CenterLoading()
          : controller.items.isEmpty
              ? const EmptyWidget(text: "there_are_no_items_in_your_basket")
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        children: controller.items.indexed
                            .map(
                              (item) => Slidable(
                                endActionPane: ActionPane(
                                  extentRatio: 0.25,
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) => controller.deleteItem(item.$1),
                                      backgroundColor: CColors.foregroundColor,
                                      foregroundColor: Colors.black,
                                      icon: Icons.delete,
                                      label: 'delete'.tr,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  height: 80,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                          image: DecorationImage(
                                            image: AssetImage(item.$2.image),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.$2.name,
                                              style: Styles.bold.copyWith(fontSize: 17),
                                            ),
                                            const Spacer(),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text("${"size".tr}: ${item.$2.size}"),
                                                      const SizedBox(height: 4),
                                                      QuantityChanger(
                                                        quantity: item.$2.quantity,
                                                        onChanged: (qty) =>
                                                            controller.changeQuantity(item.$1, qty),
                                                      ),
                                                      // Text("${"quantity".tr}: ${item.$2.quantity}"),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                DiscountedPriceWidget(
                                                  price: item.$2.totalPrice,
                                                  discountPrice: item.$2.totalDiscount,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Obx(
                      () => TotalPriceAndCompleteWidget(
                        totalPrice: controller.totalPrice,
                        pricingValue: controller.pricingValue.value,
                        showPricing: controller.showPricing,
                        completedText: "confirm_basket",
                        onCompleted: controller.confirmBasket,
                        onTap: () => controller.pricingValue.value += 0.5,
                      ),
                    ),
                    SizedBox(height: NavbarController.to.bottomAppBarHeight),
                  ],
                ),
    );
  }
}
