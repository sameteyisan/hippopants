import 'dart:convert';

class SizeModel {
  final String size;
  final int quantity;
  SizeModel({
    required this.size,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'size': size});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory SizeModel.fromMap(Map<String, dynamic> map) {
    return SizeModel(
      size: map['size'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SizeModel.fromJson(String source) => SizeModel.fromMap(json.decode(source));
}
