import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hippopants/controllers/global_controllers/global_bindings.dart';
import 'package:hippopants/services/localization_service.dart';
import 'package:hippopants/widgets/wrappers/navbar_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..errorWidget = Image.asset("assets/icon.png", width: 48)
    ..loadingStyle = EasyLoadingStyle.light;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'hippopants',
      locale: LocalizationService().locale,
      fallbackLocale: LocalizationService().fallbackLocale,
      translations: LocalizationService(),
      debugShowCheckedModeBanner: false,
      initialBinding: GlobalBindings(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
      ),
      home: const NavbarWrapper(),
      builder: EasyLoading.init(),
    );
  }
}
