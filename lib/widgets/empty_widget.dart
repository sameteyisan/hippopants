import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/theme.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Const.LOGO,
            width: Get.width * 0.5,
          ),
          const SizedBox(height: 8),
          Text(
            text.tr,
            style: Styles.bold,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
