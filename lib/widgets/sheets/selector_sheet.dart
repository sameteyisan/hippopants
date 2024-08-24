import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/extensions.dart';
import 'package:hippopants/utils/theme.dart';

class SelectorSheet extends StatelessWidget {
  const SelectorSheet({super.key, required this.title, required this.items});
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CColors.foregroundColor,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Text(
                  title.tr,
                  style: Styles.bold,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: Get.back,
                    icon: const Icon(Icons.close),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(
              children: items
                  .map((item) => ListTile(
                        title: Text(item.toLowerCaseTurkish().turkishTitleCase),
                        dense: true,
                        onTap: () => Get.back(result: item),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  static Future<String?> open(String title, List<String> items) async => Get.bottomSheet(
        SelectorSheet(title: title, items: items),
      );
}
