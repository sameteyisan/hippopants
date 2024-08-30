import 'package:flutter/material.dart';
import 'package:hippopants/utils/theme.dart';

class QuantityChanger extends StatelessWidget {
  const QuantityChanger({super.key, required this.quantity, required this.onChanged, this.max = 5});
  final int quantity;
  final int max;
  final Function(int) onChanged;

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
            child: const SizedBox(
              height: 32,
              width: 32,
              child: Icon(Icons.remove, size: 20),
            ),
          ),
          Container(
            height: 32,
            width: 32,
            alignment: Alignment.center,
            child: Text("$quantity"),
          ),
          GestureDetector(
            onTap: () {
              if (quantity < max) {
                onChanged(quantity + 1);
              }
            },
            child: const SizedBox(
              height: 32,
              width: 32,
              child: Icon(Icons.add, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
