import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my_addresses".tr),
      ),
    );
  }
}
