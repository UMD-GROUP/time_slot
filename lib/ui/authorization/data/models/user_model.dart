class UserModel {
  final String email;
  final String password;
  String name;
  String surname;
  String fcmToken;
  List interviews;

  UserModel(
      {required this.email,
      required this.password,
      this.fcmToken = '',
      this.surname = '',
      this.name = '',
      this.interviews = const []});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fcmToken: json["fcmToken"] ?? '',
      interviews: json['interviews'] ?? [],
      name: json["name"] ?? '',
      surname: json["surname"] ?? '',
      email: json["email"] ?? '',
      password: json["password"] ?? '',
    );
  }

  toJson() => {
        "email": email,
        "password": password,
        "fcmToken": fcmToken,
        "interviews": interviews,
        "name": name,
        "surname": surname,
      };
}
