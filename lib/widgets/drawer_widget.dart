import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/home_controller.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/drawer_category_tile_widget.dart';

class DrawerWidget extends GetView<HomeController> {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CColors.foregroundColor,
      width: Get.width * 0.7,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Image.asset(Const.LOGO),
            const SizedBox(height: 16),
            ...controller.categories.map((category) {
              return DrawerCategoryTileWidget(category: category);
            })
          ],
        ),
      ),
    );
  }
}
