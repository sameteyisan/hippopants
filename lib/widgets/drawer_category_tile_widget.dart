import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/models/category_model.dart';

class DrawerCategoryTileWidget extends StatelessWidget {
  const DrawerCategoryTileWidget({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: Get.back,
      contentPadding: EdgeInsets.zero,
      title: Text(category.name),
      titleAlignment: ListTileTitleAlignment.top,
      trailing: category.subCategories != null ? const Icon(Icons.keyboard_arrow_down_sharp) : null,
      // subtitle: category.subCategories != null
      //     ? Column(
      //         children: category.subCategories!
      //             .map(
      //               (e) => ListTile(
      //                 title: Text(e.name),
      //                 dense: true,r
      //               ),
      //             )
      //             .toList(),
      //       )
      //     : null,
    );
  }
}
