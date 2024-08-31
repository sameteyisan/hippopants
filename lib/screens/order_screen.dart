import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/order_controller.dart';
import 'package:hippopants/models/basket_item_modal.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/address_card.dart';
import 'package:hippopants/widgets/center_loading.dart';
import 'package:hippopants/widgets/custom/checkbox_tile_widget.dart';
import 'package:hippopants/widgets/custom/icon_button.dart';
import 'package:hippopants/widgets/custom/text_field.dart';
import 'package:hippopants/widgets/highlighted_rich_text.dart';
import 'package:hippopants/widgets/total_price_and_complete_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.items});
  final List<BasketItemModal> items;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());

    return Scaffold(
      appBar: AppBar(
        title: Text("complete_the_order".tr),
      ),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Obx(
          () => controller.isLoading.value
              ? const CenterLoading()
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: CColors.foregroundColor,
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: controller.showItems.toggle,
                                  title: Text(
                                    "Ürünleri Gör" " (${items.length})",
                                    style: Styles.bold,
                                  ),
                                  trailing: const CustomCircleIconButton(
                                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                                  ),
                                ),
                                Obx(
                                  () => controller.showItems.value
                                      ? Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            children: items
                                                .map(
                                                  (item) => Container(
                                                    margin: const EdgeInsets.only(bottom: 16),
                                                    height: 80,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 80,
                                                          height: 80,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(16),
                                                            image: DecorationImage(
                                                              image: AssetImage(item.image),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 16),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                item.name,
                                                                style: Styles.bold
                                                                    .copyWith(fontSize: 17),
                                                              ),
                                                              const Spacer(),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.end,
                                                                children: [
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                            "${"size".tr}: ${item.size}"),
                                                                        const SizedBox(height: 4),
                                                                        Text(
                                                                            "${"quantity".tr}: ${item.quantity}"),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(width: 8),
                                                                  Text(
                                                                    item.totalPrice.toCurrency,
                                                                    style: Styles.bold
                                                                        .copyWith(fontSize: 17),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (controller.deliveryAddress.value != null)
                            AddressCard(
                              address: controller.deliveryAddress.value!,
                              more: TextButton(
                                onPressed: controller.addOrEditAddress,
                                child: Text("${"add".tr} / ${"edit".tr}"),
                              ),
                            )
                          else
                            EmptyAddressCard(
                              onTap: controller.addAddress,
                            ),
                          const SizedBox(height: 16),
                          Obx(
                            () => CreditCardWidget(
                              isHolderNameVisible: true,
                              backgroundImage: "assets/logo.png",
                              cardNumber: controller.cardNumber.value,
                              expiryDate: controller.expiryDate.value,
                              labelCardHolder: "${"name".tr} ${"surname".tr}",
                              cardHolderName: controller.cardHolderName.value,
                              cvvCode: controller.cvvCode.value,
                              showBackView: controller.showBackView.value,
                              onCreditCardWidgetChange: (CreditCardBrand brand) {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                CustomTextField(
                                  labelText: "name_and_surname_on_the_card",
                                  onChanged: (txt) => controller.cardHolderName.value = txt,
                                  prefixIcon: const Icon(Icons.person_outline),
                                ),
                                const SizedBox(height: 16),
                                CustomTextField(
                                  labelText: "card_number",
                                  controller: controller.cardNumberController,
                                  onChanged: (txt) => controller.cardNumber.value = txt,
                                  prefixIcon: const Icon(Icons.credit_card_outlined),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(19),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: "${"month".tr}/${"year".tr}",
                                        controller: controller.expiryDateController,
                                        prefixIcon: const Icon(Icons.calendar_month_outlined),
                                        readOnly: true,
                                        onTap: () => controller.setExpiryDate(context),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: CustomTextField(
                                        labelText: "cvc",
                                        focusNode: controller.cvvFocus,
                                        onChanged: (txt) => controller.cvvCode.value = txt,
                                        prefixIcon: const Icon(Icons.lock_outline),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          LengthLimitingTextInputFormatter(3),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                Obx(
                                  () => CheckboxTileWidget(
                                    value: controller.terms.value,
                                    onChanged: controller.setTerms,
                                    child: HighlightedRichText(
                                      splitted:
                                          "i_have_read_and_approve_terms_conditions_and_distance_sales_contract"
                                              .tr
                                              .split("|"),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Obx(
                      () => TotalPriceAndCompleteWidget(
                        totalPrice: items.fold(0.0, (a, b) => a + b.price * b.quantity),
                        pricingValue: controller.pricingValue.value,
                        showPricing: controller.showPricing,
                        completedText: "complete_the_order",
                        onCompleted: controller.completeOrder,
                        onTap: () => controller.pricingValue.value += 0.5,
                        useSafeArea: true,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
