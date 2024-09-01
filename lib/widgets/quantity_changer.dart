import 'package:flutter/material.dart';
import 'package:hippopants/utils/theme.dart';

class QuantityChanger extends StatelessWidget {
  const QuantityChanger({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.max,
    this.size,
    this.iconSize,
  });
  final int quantity;
  final int? max;
  final Function(int) onChanged;
  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CColors.foregroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (quantity > 1) {
                onChanged(quantity - 1);
              }
            },
            child: SizedBox(
              height: size ?? 32,
              width: size ?? 32,
              child: Icon(Icons.remove, size: iconSize ?? 20),
            ),
          ),
          Container(
            height: size ?? 32,
            width: size ?? 32,
            alignment: Alignment.center,
            child: Text(
              "$quantity",
              style: iconSize != null ? Styles.bold : Styles.normal,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (quantity < (max ?? 5)) {
                onChanged(quantity + 1);
              }
            },
            child: SizedBox(
              height: size ?? 32,
              width: size ?? 32,
              child: Icon(Icons.add, size: iconSize ?? 20),
            ),
          ),
        ],
      ),
    );
  }
}
