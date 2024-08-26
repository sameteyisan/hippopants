import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/drawer_category_tile_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CColors.foregroundColor,
      width: Get.width * 0.65,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Image.asset(Const.LOGO),
            const SizedBox(height: 16),
            ...Const.DRAWER_CATEGORIES.map((category) {
              return DrawerCategoryTileWidget(category: category);
            })
          ],
        ),
      ),
    );
  }
}
