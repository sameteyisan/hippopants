import 'package:flutter/material.dart';

class OrderRich extends StatelessWidget {
  const OrderRich({super.key, required this.normal, required this.bold});
  final String normal;
  final String bold;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: normal,
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: " $bold",
            style: const TextStyle(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
