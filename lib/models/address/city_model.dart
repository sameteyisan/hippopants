import 'dart:convert';

class CityModel {
  final int id;
  final String name;
  CityModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: int.tryParse(map['id']) ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) => CityModel.fromMap(json.decode(source));
}
