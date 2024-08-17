import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.labelText, this.controller});
  final String labelText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText.tr, style: Styles.normal),
        const SizedBox(height: 4),
        Ink(
          decoration: const BoxDecoration(
            color: CColors.foregroundColor,
          ),
          child: TextFormField(
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                gapPadding: 8,
                borderSide: BorderSide(color: CColors.foregroundColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 8,
                borderSide: BorderSide(color: CColors.foregroundColor, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
