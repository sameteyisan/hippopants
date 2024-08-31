import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hippopants/utils/theme.dart';

class CreditCardExpirySheet extends StatefulWidget {
  const CreditCardExpirySheet({super.key, required this.initialDate});
  final DateTime initialDate;

  @override
  State<CreditCardExpirySheet> createState() => _CreditCardExpirySheetState();

  static Future<DateTime?> open(DateTime initialDate) async {
    return Get.bottomSheet(
      CreditCardExpirySheet(initialDate: initialDate),
    );
  }
}

class _CreditCardExpirySheetState extends State<CreditCardExpirySheet> {
  late int selectedYear;
  late int selectedMonth;

  late FixedExtentScrollController yearController;
  late FixedExtentScrollController monthController;

  @override
  void initState() {
    super.initState();

    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;

    yearController = FixedExtentScrollController(
      initialItem: selectedYear - DateTime.now().year,
    );

    monthController = FixedExtentScrollController(
      initialItem: selectedMonth - 1,
    );
  }

  @override
  void dispose() {
    yearController.dispose();
    monthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CColors.foregroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Text(
                  "expiry_date".tr,
                  style: Styles.bold,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Get.back(
                        result: DateTime(
                          selectedYear,
                          selectedMonth,
                        ),
                      );
                    },
                    icon: const Icon(Icons.check),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "month".tr,
                      style: Styles.bold,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 180,
                      child: CupertinoPicker(
                        itemExtent: 32,
                        scrollController: monthController,
                        onSelectedItemChanged: (value) {
                          setState(() {
                            selectedMonth = value + 1;
                          });
                        },
                        children: List.generate(12, (value) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (value + 1).toString().padLeft(2, "0"),
                              style: Styles.normal,
                              textAlign: TextAlign.center,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  "/",
                  style: Styles.bold,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      "year".tr,
                      style: Styles.bold,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 180,
                      child: CupertinoPicker(
                        itemExtent: 32,
                        scrollController: yearController,
                        onSelectedItemChanged: (value) {
                          setState(() {
                            selectedYear = DateTime.now().year + value;
                          });
                        },
                        children: List.generate(20, (value) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (DateTime.now().year + value).toString(),
                              style: Styles.normal,
                              textAlign: TextAlign.center,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
