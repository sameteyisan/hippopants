import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class BasketController extends GetxController {
  final isLoading = true.obs;

  @override
  void onInit() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    await Future.delayed(200.milliseconds);
    EasyLoading.dismiss();

    isLoading.value = false;
    super.onInit();
  }
}
