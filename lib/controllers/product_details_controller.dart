import 'package:get/get.dart';
import 'package:hippopants/controllers/basket_controller.dart';
import 'package:hippopants/models/product/mini_product_model.dart';
import 'package:hippopants/models/product/product_model.dart';
import 'package:hippopants/models/product/size_model.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/helpers.dart';
import 'package:hippopants/widgets/modals/animation_modal.dart';

class ProductDetailsController extends GetxController {
  final product = Rxn<ProductModel>();

  final selectedSize = Rxn<SizeModel>();

  final quantity = 1.obs;
  final currentPageIndex = 0.obs;

  final isLoading = true.obs;

  MiniProductModel miniProduct;
  ProductDetailsController(this.miniProduct);

  bool get hasDiscount => miniProduct.discountPrice != null;

  @override
  void onInit() async {
    await Future.delayed(300.milliseconds);

    final pro = Const.PRODUCTS.firstWhereOrNull((e) => e.id == miniProduct.id);
    product.value = pro;

    isLoading.value = false;

    super.onInit();
  }

  void setSize(SizeModel size) {
    selectedSize.value = size;
    if (size.quantity < quantity.value) {
      quantity.value = size.quantity;
    }
  }

  void addToBasket() async {
    if (selectedSize.value == null) {
      Helpers.showToast("you_need_to_select_a_size");
      return;
    }

    AnimationModal.show("adding_a_basket");
    await Future.delayed(1000.milliseconds);

    final basketItem =
        product.value!.toBasketItem(size: selectedSize.value!.size, quantity: quantity.value);

    if (Helpers.hasController<BasketController>()) {
      BasketController.to.items.insert(0, basketItem);
    }
    Get.back();

    Helpers.showToast("val_was_successfully_added_to_the_basket".trParams(
      {"val": miniProduct.name},
    ));
  }
}
