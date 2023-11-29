import 'dart:convert';

RestaurantModelo restaurantModeloFromJson(String str) =>
    RestaurantModelo.fromJson(json.decode(str));

String restaurantModeloToJson(RestaurantModelo data) =>
    json.encode(data.toJson());

class RestaurantModelo {
  int? statusCode;
  int? id_restaurant;
  String? restaurant;
  String? logo;
  String? telefono;
  String? descripcion;
  String? tipo;
  String? ubicacion;
  String? descOferta;
  String? oferta;
  String? message;
  bool? status;

  RestaurantModelo({
    this.statusCode = 0,
    this.id_restaurant = 0,
    this.restaurant = '',
    this.logo = '',
    this.telefono = '',
    this.descripcion = '',
    this.tipo = '',
    this.ubicacion = '',
    this.descOferta = '',
    this.oferta = '',
    this.message = '',
    this.status = false,
  });

  factory RestaurantModelo.fromJson(Map<String, dynamic> json) =>
      RestaurantModelo(
          id_restaurant: json["id_restaurant"],
          restaurant: json["restaurant"],
          logo: json["logo"],
          telefono: json["telefono"],
          descripcion: json["descripcion"],
          tipo: json["tipo"],
          ubicacion: json["ubicacion"],
          statusCode: json['statusCode'],
          descOferta: json["descOferta"],
          oferta: json["oferta"],
          message: json['message'],
          status: json['status']);

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "id_restaurant": id_restaurant,
        "restaurant": restaurant,
        "logo": logo,
        "telefono": telefono,
        "descripcion": descripcion,
        "tipo": tipo,
        "ubicacion": ubicacion,
        "descOferta": descOferta,
        "oferta": oferta,
        "message": message,
        "status": status
      };
}
