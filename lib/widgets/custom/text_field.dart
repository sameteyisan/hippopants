import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/theme.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.suffixIcon,
    this.obscureText,
    this.readOnly = false,
    this.onTap,
    this.minLines = 1,
    this.maxLines = 1,
  });
  final String labelText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool readOnly;
  final Function()? onTap;
  final int minLines;
  final int maxLines;

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
            onTap: onTap,
            readOnly: readOnly,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: obscureText ?? false,
            minLines: minLines,
            maxLines: maxLines,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              enabledBorder: const OutlineInputBorder(
                gapPadding: 8,
                borderSide: BorderSide(color: CColors.foregroundColor, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
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
