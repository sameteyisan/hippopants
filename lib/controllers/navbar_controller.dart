import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hippopants/screens/basket_screen.dart';
import 'package:hippopants/screens/home_screen.dart';
import 'package:hippopants/widgets/wrappers/profile_wrapper.dart';

enum NavbarPages {
  home,
  basket,
  profile,
}

class NavbarController extends GetxController {
  static NavbarController get to => Get.find();

  final currentPage = 0.obs;

  double bottomAppBarHeight = 0.0;

  final navbarTitle = "hippopants".obs;

  final GlobalKey bottomAppBarKey = GlobalKey();

  final navScrollers = {
    NavbarPages.home: ScrollController(),
    NavbarPages.basket: ScrollController(),
    NavbarPages.profile: ScrollController(),
  };

  final navPages = [
    const HomeScreen(key: PageStorageKey<String>("home")),
    const BasketScreen(key: PageStorageKey<String>("basket")),
    const ProfileWrapper(key: PageStorageKey<String>("profile")),
  ];

  @override
  void onClose() {
    for (final scroller in navScrollers.values) {
      scroller.dispose();
    }

    super.onClose();
  }

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = bottomAppBarKey.currentContext!.findRenderObject() as RenderBox;
      bottomAppBarHeight = renderBox.size.height;
    });
    super.onReady();
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
        navbarTitle.value = "basket";
        break;
      case NavbarPages.profile:
        navbarTitle.value = "profile";
        break;
    }
  }
}
