import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/theme.dart';

class SaleWidget extends StatelessWidget {
  const SaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "sale".tr,
        style: Styles.bold.copyWith(
          color: Colors.white,
          fontSize: 14,
        ),
      ),
    );
  }
}
