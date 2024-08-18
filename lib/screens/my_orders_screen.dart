import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my_orders".tr),
      ),
    );
  }
}
