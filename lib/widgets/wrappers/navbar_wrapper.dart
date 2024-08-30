import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/navbar_controller.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/widgets/drawer_widget.dart';

class NavbarWrapper extends StatelessWidget {
  const NavbarWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = NavbarController.to;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        title: Obx(() => Text(controller.navbarTitle.value.tr)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Image.asset(Const.ICON),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      bottomNavigationBar: BottomAppBar(
        key: controller.bottomAppBarKey,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        notchMargin: 32,
        child: Obx(
          () => NavigationBar(
            selectedIndex: controller.currentPage.value,
            onDestinationSelected: controller.changePage,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home),
                label: 'explore'.tr,
              ),
              NavigationDestination(
                icon: const Icon(Icons.shopping_basket),
                label: 'basket'.tr,
              ),
              NavigationDestination(
                icon: const Icon(Icons.person),
                label: 'profile'.tr,
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => controller.changePage(1),
      //   child: const Icon(Icons.shopping_basket),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(() {
        return controller.navPages[controller.currentPage.value];
      }),
    );
  }
}
