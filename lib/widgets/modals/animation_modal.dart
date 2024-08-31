import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/theme.dart';

class AnimationModal extends StatelessWidget {
  const AnimationModal({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Const.LOGO,
                width: Get.width * 0.5,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                text.tr,
                style: Styles.bold.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void show(String text) => Get.dialog(AnimationModal(text: text));
}
