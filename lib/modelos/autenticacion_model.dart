import 'dart:convert';

AuthModelo authModeloFromJson(String str) =>
    AuthModelo.fromJson(json.decode(str));

String authModeloToJson(AuthModelo data) => json.encode(data.toJson());

class AuthModelo {
  int statusCode;
  bool status;
  String message;
  dynamic user;
  String token;

  AuthModelo({
    this.statusCode = 0,
    this.status = false,
    this.message = '',
    this.user = '',
    this.token = '',
  });

  factory AuthModelo.fromJson(Map<String, dynamic> json) {
    return AuthModelo(
      statusCode:
          json["statusCode"] ?? 0, // Usa 0 como valor predeterminado si es nulo
      status: json["status"] ??
          false, // Usa false como valor predeterminado si es nulo
      message: json["message"] ??
          '', // Usa una cadena vacía como valor predeterminado si es nulo
      user: json["user"] ??
          '', // Usa una cadena vacía como valor predeterminado si es nulo
      token: json["token"] ??
          '', // Usa una cadena vacía como valor predeterminado si es nulo
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "user": user,
        "token": token,
      };
}
