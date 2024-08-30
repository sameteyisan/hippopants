import 'dart:convert';

import 'package:hippopants/models/basket_item_modal.dart';
import 'package:hippopants/models/product/size_model.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final List<String> images;
  final List<SizeModel> sizes;
  final List<String> availableSizes;
  final double price;
  final int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.sizes,
    required this.price,
    required this.availableSizes,
    required this.quantity,
  });

  String get image => images[0];

  BasketItemModal toBasketItem(String size) => BasketItemModal(
        id: id,
        name: name,
        image: image,
        size: size,
        price: price,
        quantity: 1,
      );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'images': images});
    result.addAll({'sizes': sizes.map((x) => x.toMap()).toList()});
    result.addAll({'availableSizes': availableSizes});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      images: List<String>.from(map['images']),
      sizes: List<SizeModel>.from(map['sizes']?.map((x) => SizeModel.fromMap(x))),
      availableSizes: List<String>.from(map['availableSizes']),
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}
