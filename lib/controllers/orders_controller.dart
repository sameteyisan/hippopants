import 'package:get/get.dart';
import 'package:hippopants/models/order_model.dart';
import 'package:hippopants/utils/const.dart';

class OrdersController extends GetxController {
  final isLoading = true.obs;

  final orders = <OrderModel>[].obs;

  @override
  void onInit() async {
    await Future.delayed(300.milliseconds);
    orders.value = Const.ORDERS;

    isLoading.value = false;
    super.onInit();
  }
}
