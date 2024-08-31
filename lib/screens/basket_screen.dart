import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/basket_controller.dart';
import 'package:hippopants/controllers/navbar_controller.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/empty_widget.dart';
import 'package:hippopants/widgets/quantity_changer.dart';

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
                                                Text(
                                                  item.$2.totalPrice.toCurrency,
                                                  style: Styles.bold.copyWith(fontSize: 17),
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
                      () => Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        color: CColors.foregroundColor,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedSize(
                              duration: 200.milliseconds,
                              child: Container(
                                height: controller.showPricing ? 40 : 0,
                                margin: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("${"total".tr}:"),
                                          Text("${"delivery_fee".tr}:"),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(controller.totalPrice.toCurrency),
                                          Text(
                                            controller.totalPrice < 500
                                                ? Const.DELIVERY_FEE.toCurrency
                                                : "free_delivery".tr,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    onTap: () => controller.pricingValue.value += 0.5,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Obx(() => AnimatedRotation(
                                              turns: controller.pricingValue.value,
                                              duration: 200.milliseconds,
                                              child: const Icon(Icons.keyboard_arrow_down),
                                            )),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("total".tr),
                                            Text(
                                              (controller.totalPrice +
                                                      (controller.totalPrice < 500
                                                          ? Const.DELIVERY_FEE
                                                          : 0))
                                                  .toCurrency,
                                              style: Styles.bold,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                    flex: 3,
                                    child: FilledButton(
                                      onPressed: controller.confirmBasket,
                                      child: Text("confirm_basket".tr),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: NavbarController.to.bottomAppBarHeight),
                  ],
                ),
    );
  }
}
