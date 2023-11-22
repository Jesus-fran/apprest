import 'dart:convert';
import 'package:baseapp/config.dart';
import 'package:baseapp/modelos/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String url = '${Config.baseUrl}/api/restaurant/info-basic';

Future<RestaurantModelo> getRestaurantInfoBasic(String tokenUser) async {
  final response = await http.post(Uri.parse(url), headers: {
    "Authorization": "Bearer $tokenUser",
    'Accept': 'application/json'
  });
  String body = utf8.decode(response.bodyBytes);
  final data = restaurantModeloFromJson(body);
  data.statusCode = response.statusCode;
  return data;
}

Future<RestaurantModelo> setRestaurantInfoBasic(
    String tokenUser, RestaurantModelo info) async {
  String url = '${Config.baseUrl}/api/restaurant/update-info-basic';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      "Authorization": "Bearer $tokenUser",
      'Accept': 'application/json'
    },
    body: {
      'logo': info.logo,
      'restaurant': info.restaurant,
      'telefono': info.telefono,
      'tipo': info.tipo,
      'descripcion': info.descripcion,
    },
  );
  String body = utf8.decode(response.bodyBytes);
  debugPrint(body);
  final data = restaurantModeloFromJson(body);
  data.statusCode = response.statusCode;
  return data;
}
