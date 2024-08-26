import 'dart:convert';

import 'package:hippopants/models/product/product_model.dart';
import 'package:hippopants/utils/const.dart';

class OrderModel {
  final int number;
  final DateTime date;
  final OrderStatus status;
  final int count;
  final double price;
  final List<ProductModel> products;

  OrderModel({
    required this.number,
    required this.date,
    required this.status,
    required this.count,
    required this.price,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'number': number});
    result.addAll({'date': date.millisecondsSinceEpoch});
    result.addAll({'status': status.name});
    result.addAll({'count': count});
    result.addAll({'price': price});
    result.addAll({'products': products.map((x) => x.toMap()).toList()});

    return result;
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      number: map['number']?.toInt() ?? 0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      status: OrderStatus.values.firstWhere((e) => e.name == map['status']),
      count: map['count']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      products: List<ProductModel>.from(map['products']?.map((x) => ProductModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));
}
