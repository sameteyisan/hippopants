import 'package:get/get.dart';
import 'package:hippopants/models/basket_item_modal.dart';
import 'package:hippopants/screens/order_screen.dart';
import 'package:hippopants/utils/extensions.dart';

class BasketController extends GetxController {
  static BasketController get to => Get.find();

  final isLoading = true.obs;

  final pricingValue = 0.0.obs;

  final items = <BasketItemModal>[].obs;

  bool get showPricing => pricingValue.value.fract != 0;
  double get totalPrice => items.fold(0.0, (a, b) => a + b.price * b.quantity);

  @override
  void onInit() async {
    await Future.delayed(200.milliseconds);

    isLoading.value = false;
    super.onInit();
  }

  void deleteItem(int index) {
    items.removeAt(index);
  }

  void changeQuantity(int index, int quantity) {
    items[index] = items[index].copyWith(quantity: quantity);
    items.refresh();
  }

  void confirmBasket() {
    Get.to(const OrderScreen());
  }
}
