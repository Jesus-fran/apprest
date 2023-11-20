import 'dart:convert';

PlanModel planModelFromJson(String str) => PlanModel.fromJson(json.decode(str));

String authModeloToJson(PlanModel data) => json.encode(data.toJson());

class PlanModel {
  int statusCode;
  bool status;
  String message;
  String plan;
  bool card;

  PlanModel({
    this.statusCode = 0,
    this.status = false,
    this.message = '',
    this.plan = '',
    this.card = false,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      statusCode:
          json["statusCode"] ?? 0, // Usa 0 como valor predeterminado si es nulo
      status: json["status"] ??
          false, // Usa false como valor predeterminado si es nulo
      message: json["message"] ??
          '', // Usa una cadena vacía como valor predeterminado si es nulo
      plan: json["plan"] ??
          '', // Usa una cadena vacía como valor predeterminado si es nulo
      card: json["card"] ??
          false, // Usa false como valor predeterminado si es nulo
    );
  }

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
        "plan": plan,
        "card": card,
      };
}
