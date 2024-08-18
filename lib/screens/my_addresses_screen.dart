import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAddressesScreen extends StatelessWidget {
  const MyAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my_addresses".tr),
      ),
    );
  }
}
