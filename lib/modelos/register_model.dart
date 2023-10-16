import 'dart:convert';

RegisterModelo registerModeloFromJson(String str) =>
    RegisterModelo.fromJson(json.decode(str));

String registerModeloToJson(RegisterModelo data) => json.encode(data.toJson());

class RegisterModelo {
  int statusCode;
  bool status;
  String message;
  dynamic user;
  String token;

  RegisterModelo({
    this.statusCode = 0,
    this.status = false,
    this.message = '',
    this.user = '',
    this.token = '',
  });

  factory RegisterModelo.fromJson(Map<String, dynamic> json) {
    return RegisterModelo(
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
