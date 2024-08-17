import 'dart:io';

import 'package:get/get.dart';
import 'package:hippopants/services/localization_service.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();

  final currentLocale = LocalizationService().locale.obs;
  final currentSelectedLanguageIdx = 0.obs;

  @override
  void onInit() async {
    debounce(currentSelectedLanguageIdx, (int index) async {
      final lang = LocalizationService().langs[index];
      final locale = await LocalizationService().changeLocale(lang);
      currentLocale.value = locale;
      // await configBox.put("language", index.toString());
    }, time: const Duration(milliseconds: 20));

    // final String? idx = configBox.get("language");
    final deviceLocaleName = Platform.localeName.split("_").first;
    int deviceLocaleIdx =
        LocalizationService().locales.indexWhere((e) => e.languageCode == deviceLocaleName);
    if (deviceLocaleIdx == -1) deviceLocaleIdx = 0;
    changeLocale(0, false);

    // changeLocale(int.tryParse(idx ?? "") ?? deviceLocaleIdx, false);

    super.onInit();
  }

  void changeLocale(int? index, bool fetch) {
    currentSelectedLanguageIdx.value = index ?? 0;
  }
}
