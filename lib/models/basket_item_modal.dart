import 'dart:convert';

class BasketItemModal {
  final int id;
  final String name;
  final String image;
  final String size;
  final double price;
  final double? discountPrice;
  final int quantity;

  BasketItemModal({
    required this.id,
    required this.name,
    required this.image,
    required this.size,
    required this.price,
    this.discountPrice,
    required this.quantity,
  });

  double get totalPrice => price * quantity;
  double? get totalDiscount => discountPrice != null ? (discountPrice! * quantity) : null;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'image': image});
    result.addAll({'size': size});
    result.addAll({'price': price});
    result.addAll({'discount_price': discountPrice});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory BasketItemModal.fromMap(Map<String, dynamic> map) {
    return BasketItemModal(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      size: map['size'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      discountPrice: map['discount_price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory BasketItemModal.fromJson(String source) => BasketItemModal.fromMap(json.decode(source));

  BasketItemModal copyWith({
    int? id,
    String? name,
    String? image,
    String? size,
    double? price,
    double? discountPrice,
    int? quantity,
  }) {
    return BasketItemModal(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      size: size ?? this.size,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      quantity: quantity ?? this.quantity,
    );
  }
}
