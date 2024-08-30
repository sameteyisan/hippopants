import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/home_controller.dart';
import 'package:hippopants/models/category_model.dart';

class DrawerCategoryTileWidget extends GetView<HomeController> {
  const DrawerCategoryTileWidget({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isOpen = controller.categoryExpandedStatus[category.name] == true;

      return Column(
        children: [
          ListTile(
            onTap: () => controller.setCategoryExpandedStatus(category.name),
            contentPadding: EdgeInsets.zero,
            title: Text(category.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            titleAlignment: ListTileTitleAlignment.top,
            trailing: _buildTrailingIcon(isOpen, category.subCategories),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child:
                isOpen ? _buildSubCategoryList(category.subCategories, 1) : const SizedBox.shrink(),
          ),
        ],
      );
    });
  }

  Widget _buildSubCategoryList(List<CategoryModel>? subCategories, int level) {
    if (subCategories == null) return const SizedBox.shrink();

    return Column(
      children: subCategories.map((subCategory) {
        return Obx(() {
          final subIsOpen = controller.categoryExpandedStatus[subCategory.name] == true;

          return Column(
            children: [
              ListTile(
                onTap: () => controller.setCategoryExpandedStatus(subCategory.name),
                contentPadding: EdgeInsets.only(left: 20.0 * level),
                title: Text(
                  subCategory.name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                titleAlignment: ListTileTitleAlignment.top,
                trailing: _buildTrailingIcon(subIsOpen, subCategory.subCategories),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: subIsOpen
                    ? _buildSubCategoryList(subCategory.subCategories, level + 1)
                    : const SizedBox.shrink(),
              ),
            ],
          );
        });
      }).toList(),
    );
  }

  Widget _buildTrailingIcon(bool isOpen, List<CategoryModel>? subCategories) {
    if (subCategories == null) return const SizedBox.shrink();

    return Icon(isOpen ? Icons.keyboard_arrow_down_sharp : Icons.keyboard_arrow_right_sharp);
  }
}
