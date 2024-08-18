import 'package:flutter/material.dart';

class CheckboxTileWidget extends StatelessWidget {
  const CheckboxTileWidget({super.key, required this.child, required this.value, this.onChanged});
  final Widget child;
  final bool value;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
