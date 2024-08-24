import 'dart:convert';

class ProfileModel {
  final int id;
  final String name;
  final String surname;
  final String username;
  final String email;
  final String password;
  final bool electronicMessages;

  ProfileModel({
    required this.id,
    required this.name,
    required this.surname,
    required this.username,
    required this.email,
    required this.password,
    required this.electronicMessages,
  });

  String get fullname => "$name $surname";

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'surname': surname});
    result.addAll({'username': username});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'electronic_messages': electronicMessages});

    return result;
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      electronicMessages: map['electronic_messages'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) => ProfileModel.fromMap(json.decode(source));

  ProfileModel copyWith({
    int? id,
    String? name,
    String? surname,
    String? username,
    String? email,
    String? password,
    bool? electronicMessages,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      electronicMessages: electronicMessages ?? this.electronicMessages,
    );
  }
}
