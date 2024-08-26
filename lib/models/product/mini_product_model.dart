class MiniProductModel {
  final String name;
  final List<String> images;
  final double price;

  MiniProductModel({
    required this.name,
    required this.images,
    required this.price,
  });

  String get image => images[0];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'image': images});
    result.addAll({'price': price});

    return result;
  }

  factory MiniProductModel.fromMap(Map<String, dynamic> map) {
    return MiniProductModel(
      name: map['name'] ?? '',
      images: List<String>.from(map['images']),
      price: map['price']?.toDouble() ?? 0.0,
    );
  }
}
