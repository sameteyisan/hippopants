import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/auth_controller.dart';
import 'package:hippopants/controllers/navbar_controller.dart';
import 'package:hippopants/screens/account_details_screen.dart';
import 'package:hippopants/screens/addresses_screen.dart';
import 'package:hippopants/screens/orders_screen.dart';

class ProfileScreem extends GetView<AuthController> {
  const ProfileScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: NavbarController.to.currentScroller,
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.shopping_basket_outlined),
          title: Text("my_orders".tr),
          onTap: () => Get.to(const OrdersScreen()),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: Text("my_addresses".tr),
          onTap: () => Get.to(const AddressesScreen()),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: Text("account_details".tr),
          onTap: () => Get.to(const AccountDetailsScreen()),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: Text("sign_out".tr),
          onTap: controller.signOut,
        ),
        const SizedBox(height: 32),
        Center(
          child: Image.asset(
            "assets/logo.png",
            width: Get.width * 0.6,
          ),
        ),
      ],
    );
  }
}
