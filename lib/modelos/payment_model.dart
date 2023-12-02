import 'dart:convert';

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  bool status;
  String message;

  PaymentModel({
    this.status = false,
    this.message = '',
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        status: json["status"] ??
            false, // Usa false como valor predeterminado si es nulo
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
