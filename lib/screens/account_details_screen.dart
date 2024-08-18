import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("account_details".tr),
      ),
    );
  }
}
