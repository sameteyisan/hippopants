import 'dart:convert';

class CountyModel {
  final int id;
  final int cityID;
  final String name;
  CountyModel({
    required this.id,
    required this.cityID,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'il_id': cityID});
    result.addAll({'name': name});

    return result;
  }

  factory CountyModel.fromMap(Map<String, dynamic> map) {
    return CountyModel(
      id: int.tryParse(map['id']) ?? 0,
      cityID: int.tryParse(map['il_id']) ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CountyModel.fromJson(String source) => CountyModel.fromMap(json.decode(source));
}
