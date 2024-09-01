import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/animated.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/theme.dart';

class TotalPriceAndCompleteWidget extends StatelessWidget {
  const TotalPriceAndCompleteWidget({
    super.key,
    required this.totalPrice,
    required this.pricingValue,
    required this.showPricing,
    required this.completedText,
    required this.onCompleted,
    required this.onTap,
    this.useSafeArea = false,
  });
  final double totalPrice;
  final double pricingValue;
  final bool showPricing;
  final String completedText;
  final Function() onCompleted;
  final Function() onTap;
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      color: CColors.foregroundColor,
      child: SafeArea(
        bottom: useSafeArea,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSize(
              duration: 200.milliseconds,
              child: Container(
                height: showPricing ? 40 : 0,
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
                          Text(totalPrice.toCurrency),
                          Text(
                            totalPrice < 500 ? Const.DELIVERY_FEE.toCurrency : "free_delivery".tr,
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
                    onTap: onTap,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedRotation(
                          turns: pricingValue,
                          duration: 200.milliseconds,
                          child: const Icon(Icons.keyboard_arrow_down),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("total".tr),
                            Animated(
                              value: totalPrice + (totalPrice < 500 ? Const.DELIVERY_FEE : 0),
                              builder: (context, child, animation) => Text(
                                animation.value.toCurrency,
                                style: Styles.bold,
                              ),
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
                    onPressed: onCompleted,
                    child: Text(completedText.tr),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
