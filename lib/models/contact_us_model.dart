class ContactUsModel {
  final String name;
  final String email;
  final String subject;
  final String message;

  ContactUsModel(
      {required this.name, required this.email, required this.subject, required this.message});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'subject': subject});
    result.addAll({'message': message});

    return result;
  }
}
