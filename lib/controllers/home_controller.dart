import 'package:get/get.dart';
import 'package:hippopants/models/category_model.dart';
import 'package:hippopants/screens/contact_us_screen.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/helpers.dart';

class HomeController extends GetxController {
  final categories = <CategoryModel>[].obs;
  final categoryExpandedStatus = <String, bool>{}.obs;

  @override
  void onInit() {
    _initializeCategories();
    super.onInit();
  }

  void _initializeCategories() {
    categories.addAll(Const.DRAWER_CATEGORIES);

    for (final category in categories) {
      _initializeCategoryStatus(category);
    }
  }

  void _initializeCategoryStatus(CategoryModel category) {
    if (category.subCategories != null) {
      categoryExpandedStatus[category.name] = false;
    }

    category.subCategories?.forEach((subCategory) {
      if (subCategory.subCategories != null) {
        categoryExpandedStatus[subCategory.name] = false;
      }
      subCategory.subCategories?.forEach((subSubCategory) {
        if (subSubCategory.subCategories != null) {
          categoryExpandedStatus[subSubCategory.name] = false;
        }
      });
    });
  }

  void setCategoryExpandedStatus(String name) {
    if (categoryExpandedStatus.containsKey(name)) {
      categoryExpandedStatus[name] = !categoryExpandedStatus[name]!;
    } else {
      switch (name) {
        case "Bize Ulaşın":
          Get.to(const ContactUsScreen());

          break;
        default:
          Helpers.showToast("Not implemented yet.");
      }
    }
  }
}
