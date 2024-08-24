import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hippopants/models/order_model.dart';
import 'package:hippopants/utils/const.dart';

class OrdersController extends GetxController {
  final orders = <OrderModel>[].obs;

  @override
  void onInit() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);

    await Future.delayed(300.milliseconds);
    orders.value = Const.ORDERS;

    EasyLoading.dismiss();
    super.onInit();
  }
}
