import 'package:flutter/material.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/theme.dart';

class DiscountedPriceWidget extends StatelessWidget {
  const DiscountedPriceWidget(
      {super.key, required this.price, this.discountPrice, this.horizontal = false});

  final double price;
  final double? discountPrice;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount = discountPrice != null;
    List<Widget> children = [
      if (hasDiscount)
        Text(
          price.toCurrency,
          style: Styles.normal.copyWith(
            fontSize: 14,
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      if (horizontal) const SizedBox(width: 8),
      Text(
        hasDiscount ? discountPrice!.toCurrency : price.toCurrency,
        style: Styles.bold.copyWith(fontSize: 17),
      ),
    ];
    if (horizontal) {
      return Row(
        children: children,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
