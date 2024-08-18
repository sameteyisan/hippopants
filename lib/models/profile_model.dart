import 'dart:convert';

class ProfileModel {
  final String name;
  final String surname;
  final String usernameOrEmail;
  final String password;
  final bool electronicMessages;

  ProfileModel({
    required this.name,
    required this.surname,
    required this.usernameOrEmail,
    required this.password,
    required this.electronicMessages,
  });

  String get fullname => "$name $surname";

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'surname': surname});
    result.addAll({'username_or_email': usernameOrEmail});
    result.addAll({'password': password});
    result.addAll({'electronic_messages': electronicMessages});

    return result;
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      usernameOrEmail: map['username_or_email'] ?? '',
      password: map['password'] ?? '',
      electronicMessages: map['electronic_messages'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) => ProfileModel.fromMap(json.decode(source));
}
