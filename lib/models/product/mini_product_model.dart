class MiniProductModel {
  final int id;
  final String name;
  final List<String> images;
  final double price;
  final double? discountPrice;

  MiniProductModel({
    required this.id,
    required this.name,
    required this.images,
    required this.price,
    this.discountPrice,
  });

  String get image => images[0];

  factory MiniProductModel.fromMap(Map<String, dynamic> map) {
    return MiniProductModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      images: List<String>.from(map['images']),
      price: map['price']?.toDouble() ?? 0.0,
      discountPrice: map['discount_price']?.toDouble() ?? 0.0,
    );
  }
}
