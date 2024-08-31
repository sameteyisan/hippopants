import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/models/product/product_model.dart';
import 'package:hippopants/models/product/size_model.dart';
import 'package:hippopants/utils/helpers.dart';
import 'package:hippopants/utils/theme.dart';

class SizeChanger extends StatefulWidget {
  const SizeChanger({super.key, required this.product, required this.onChanged});
  final ProductModel product;
  final Function(SizeModel) onChanged;

  @override
  State<SizeChanger> createState() => _SizeChangerState();
}

class _SizeChangerState extends State<SizeChanger> {
  SizeModel? selectedSize;

  void setSize(SizeModel size) {
    final isAvailable = widget.product.availableSizes.contains(size.size);

    if (isAvailable) {
      setState(() {
        selectedSize = size;
        widget.onChanged(size);
      });
    } else {
      Helpers.showToast("this_size_not_available_for_now");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.product.sizes.map((e) {
        final selected = selectedSize == e;
        final isAvailable = widget.product.availableSizes.contains(e.size);

        return AnimatedOpacity(
          duration: 200.milliseconds,
          opacity: isAvailable ? 1 : 0.3,
          child: GestureDetector(
            onTap: () => setSize(e),
            child: AnimatedContainer(
              duration: 200.milliseconds,
              alignment: Alignment.center,
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 1,
                  color: Colors.black.withOpacity(selected ? 1 : 0.4),
                ),
              ),
              child: Text(
                e.size,
                style: selected ? Styles.bold : Styles.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
