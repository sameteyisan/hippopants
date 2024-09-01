import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/controllers/home_controller.dart';
import 'package:hippopants/controllers/navbar_controller.dart';
import 'package:hippopants/screens/category_products_screen.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/highlighted_rich_text.dart';
import 'package:hippopants/widgets/promotion_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());

    return ListView(
      controller: NavbarController.to.currentScroller,
      children: [
        SizedBox(
          height: 200,
          width: Get.width,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: 500.milliseconds,
              viewportFraction: 1,
            ),
            key: const PageStorageKey("banner"),
            items: Const.BANNERS
                .map(
                  (banner) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(banner),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "welcome".tr,
                style: Styles.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              HighlightedRichText(splitted: "welcome2".tr.split("|")),
              const SizedBox(height: 16),
              ...Const.CATEGORIES.map(
                (category) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () => Get.to(const CategoryProductsScreen()),
                    child: Image.asset(
                      category,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ...Const.PROMOTIONS.map(
                (promotion) => Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: PromotionCard(promotion: promotion),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
