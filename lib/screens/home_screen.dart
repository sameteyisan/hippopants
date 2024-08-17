import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/const.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/highlighted_rich_text.dart';
import 'package:hippopants/widgets/promotion_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Image.asset(Const.ICON),
        ),
        title: const Text("hippopants"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            child: CarouselView(
              itemSnapping: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              itemExtent: MediaQuery.of(context).size.width,
              children: Const.BANNERS
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
                    child: Image.asset(category),
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
      ),
    );
  }
}
