import 'package:get/get.dart';
import 'package:hippopants/models/product/mini_product_model.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/widgets/sheets/add_basket_sheet.dart';

class CategoryProductsController extends GetxController {
  final isLoading = true.obs;

  final products = <MiniProductModel>[].obs;

  @override
  void onInit() async {
    await Future.delayed(300.milliseconds);

    products.addAll(Const.WOMEN_PRODUCTS);
    isLoading.value = false;
    super.onInit();
  }

  void addToBasket(MiniProductModel product) async {
    AddBasketSheet.show(product);
  }
}
