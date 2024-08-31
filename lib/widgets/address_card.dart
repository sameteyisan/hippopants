import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hippopants/models/address/address_model.dart';
import 'package:hippopants/utils/theme.dart';

class AddressCard extends StatelessWidget {
  const AddressCard(
      {super.key, required this.address, this.onEdited, this.more, this.selected = false});
  final AddressModel address;
  final Function()? onEdited;
  final Widget? more;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: onEdited != null
          ? ActionPane(
              extentRatio: 0.25,
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) => onEdited!(),
                  backgroundColor: CColors.foregroundColor,
                  foregroundColor: Colors.black,
                  icon: Icons.edit,
                  label: 'edit'.tr,
                ),
              ],
            )
          : null,
      child: AnimatedContainer(
        duration: 200.milliseconds,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: selected ? Colors.black : CColors.foregroundColor),
          color: CColors.foregroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    address.fullname,
                    style: Styles.bold.copyWith(fontSize: 17),
                  ),
                ),
                if (more != null) more!,
              ],
            ),
            const SizedBox(height: 8),
            Text(
              address.address,
              style: Styles.normal,
            ),
            const SizedBox(height: 8),
            Text(
              address.cityCounty,
              style: Styles.normal,
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyAddressCard extends StatelessWidget {
  const EmptyAddressCard({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: CColors.foregroundColor,
        ),
        child: Column(
          children: [
            const Icon(
              Icons.add,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              "you_dont_have_an_address_yet_add_an_address_now".tr,
              style: Styles.normal,
            ),
          ],
        ),
      ),
    );
  }
}
