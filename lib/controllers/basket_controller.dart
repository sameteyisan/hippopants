import 'package:get/get.dart';

class BasketController extends GetxController {
  final isLoading = true.obs;

  @override
  void onInit() async {
    await Future.delayed(200.milliseconds);

    isLoading.value = false;
    super.onInit();
  }
}
