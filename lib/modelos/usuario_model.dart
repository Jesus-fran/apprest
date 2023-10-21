import 'dart:convert';

UserModelo userModeloFromJson(String str) =>
    UserModelo.fromJson(json.decode(str));

String userModeloToJson(UserModelo data) =>
    json.encode(data.toJson());

class UserModelo {
  String email;
  String password;
  String username;

  UserModelo({
    this.email = '',
    this.password = '',
    this.username = '',
  });

  factory UserModelo.fromJson(Map<String, dynamic> json) =>
      UserModelo(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "username": username,
      };
}
