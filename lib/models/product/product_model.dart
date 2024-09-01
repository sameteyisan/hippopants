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
  final double? discountPrice;
  final int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.sizes,
    required this.price,
    this.discountPrice,
    required this.availableSizes,
    required this.quantity,
  });

  String get image => images[0];

  BasketItemModal toBasketItem({required String size, required int quantity}) => BasketItemModal(
        id: id,
        name: name,
        image: image,
        size: size,
        price: price,
        discountPrice: discountPrice,
        quantity: quantity,
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
    result.addAll({'discount_price': discountPrice});
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
      discountPrice: map['discount_price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    List<String>? images,
    List<SizeModel>? sizes,
    List<String>? availableSizes,
    double? price,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
      availableSizes: availableSizes ?? this.availableSizes,
      price: price ?? this.price,
      discountPrice: discountPrice ?? discountPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}
