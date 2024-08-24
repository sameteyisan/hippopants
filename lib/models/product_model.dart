import 'dart:convert';

class ProductModel {
  final String name;
  final List<String> images;
  final List<String> sizes;
  final List<String> availableSizes;
  final double price;
  final int quantity;

  ProductModel({
    required this.name,
    required this.images,
    required this.sizes,
    required this.price,
    required this.availableSizes,
    required this.quantity,
  });

  String get image => images[0];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'image': images});
    result.addAll({'sizes': sizes});
    result.addAll({'available_sizes': availableSizes});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      images: List<String>.from(map['images']),
      sizes: List<String>.from(map['sizes']),
      availableSizes: List<String>.from(map['available_sizes']),
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}
