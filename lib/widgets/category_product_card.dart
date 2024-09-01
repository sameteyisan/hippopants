import 'package:flutter/material.dart';
import 'package:hippopants/models/product/mini_product_model.dart';
import 'package:hippopants/utils/theme.dart';
import 'package:hippopants/widgets/custom/icon_button.dart';
import 'package:hippopants/widgets/discounted_price_widget.dart';
import 'package:hippopants/widgets/page_indicator.dart';
import 'package:hippopants/widgets/sale_widget.dart';

class CategoryProductCard extends StatefulWidget {
  const CategoryProductCard(
      {super.key, required this.product, required this.onTap, required this.onAddedToBasket});
  final MiniProductModel product;
  final Function() onTap;
  final Function() onAddedToBasket;

  @override
  State<CategoryProductCard> createState() => _CategoryProductCardState();
}

class _CategoryProductCardState extends State<CategoryProductCard> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CColors.foregroundColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              spreadRadius: 1,
              blurRadius: 1,
              color: Colors.black.withOpacity(0.1),
            )
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: PageView(
                    onPageChanged: (value) {
                      setState(() {
                        currentPageIndex = value;
                      });
                    },
                    children: widget.product.images
                        .map((image) => Image.asset(
                              image,
                              width: double.infinity,
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.product.images.indexed
                      .map((e) => PageIndicator(selected: e.$1 == currentPageIndex))
                      .toList(),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.product.name,
                    style: Styles.bold.copyWith(fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: DiscountedPriceWidget(
                          price: widget.product.price,
                          discountPrice: widget.product.discountPrice,
                        ),
                      ),
                      const SizedBox(width: 4),
                      CustomIconButton(
                        backgroundColor: Colors.white,
                        icon: const Icon(Icons.shopping_basket),
                        onTap: widget.onAddedToBasket,
                      )
                    ],
                  ),
                ),
              ],
            ),
            if (widget.product.discountPrice != null)
              const Positioned(
                right: 8,
                child: SaleWidget(),
              ),
          ],
        ),
      ),
    );
  }
}
