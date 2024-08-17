import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hippopants/screens/basket_screen.dart';
import 'package:hippopants/screens/home_screen.dart';
import 'package:hippopants/screens/profile_screen.dart';

enum NavbarPages {
  home,
  basket,
  profile,
}

class NavbarController extends GetxController {
  static NavbarController get to => Get.find();

  final currentPage = 0.obs;
  final navbarTitle = "hippopants".obs;

  final navScrollers = {
    NavbarPages.home: ScrollController(),
    NavbarPages.basket: ScrollController(),
    NavbarPages.profile: ScrollController(),
  };

  final navPages = [
    const HomeScreen(key: PageStorageKey<String>("home")),
    const BasketScreen(key: PageStorageKey<String>("basket")),
    const ProfileScreen(key: PageStorageKey<String>("profile")),
  ];

  @override
  void onClose() {
    for (final scroller in navScrollers.values) {
      scroller.dispose();
    }

    super.onClose();
  }

  void scrollToTop(NavbarPages page) {
    if (navScrollers[page]!.hasClients) {
      navScrollers[page]!.animateTo(
        0,
        duration: 1.seconds,
        curve: Curves.ease,
      );
    }
  }

  ScrollController get currentScroller => navScrollers[NavbarPages.values[currentPage.value]]!;

  bool isOnPage(NavbarPages page) => currentPage.value == page.index;

  void changePage(int index) async {
    final page = NavbarPages.values[index];
    print(page);

    if (currentPage.value == page.index) {
      scrollToTop(page);
      return;
    }

    currentPage.value = page.index;
    switch (page) {
      case NavbarPages.home:
        navbarTitle.value = "hippopants";
        break;
      case NavbarPages.basket:
        print("evet");
        navbarTitle.value = "basket";
        break;
      case NavbarPages.profile:
        navbarTitle.value = "profile";
        break;

      default:
    }
  }
}
