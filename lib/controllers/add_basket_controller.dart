import 'package:get/get.dart';
import 'package:hippopants/controllers/basket_controller.dart';
import 'package:hippopants/models/product/mini_product_model.dart';
import 'package:hippopants/models/product/product_model.dart';
import 'package:hippopants/models/product/size_model.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/helpers.dart';
import 'package:hippopants/widgets/modals/adding_basket_modal.dart';

class AddBasketController extends GetxController {
  final isLoading = true.obs;

  final product = Rxn<ProductModel>();

  final selectedSize = Rxn<SizeModel>();

  MiniProductModel miniProduct;
  AddBasketController(this.miniProduct);

  @override
  void onInit() async {
    await Future.delayed(300.milliseconds);

    final pro = Const.PRODUCTS.firstWhereOrNull((e) => e.id == miniProduct.id);
    product.value = pro;

    isLoading.value = false;
    super.onInit();
  }

  void addToBasket() async {
    if (selectedSize.value == null) {
      Helpers.showToast("you_need_to_select_a_size");
      return;
    }

    AddingBasketModal.show();
    await Future.delayed(1000.milliseconds);

    final basketItem = product.value!.toBasketItem(selectedSize.value!.size);

    if (Helpers.hasController<BasketController>()) {
      BasketController.to.items.insert(0, basketItem);
    }
    Get.back();

    Helpers.showToast("val_was_successfully_added_to_the_basket".trParams(
      {"val": miniProduct.name},
    ));
  }
}
