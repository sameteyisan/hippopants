import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/models/promotion_model.dart';
import 'package:hippopants/widgets/highlighted_rich_text.dart';

class PromotionCard extends StatelessWidget {
  const PromotionCard({super.key, required this.promotion});
  final PromotionModel promotion;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          promotion.image,
          width: 48,
        ),
        const SizedBox(height: 16),
        HighlightedRichText(
          splitted: promotion.text.tr.split("|"),
        )
      ],
    );
  }
}
