import 'dart:convert';
import 'package:baseapp/config.dart';
import 'package:baseapp/modelos/autenticacion_model.dart';
import 'package:baseapp/modelos/restaurant_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String url = '${Config.baseUrl}/api/restaurant/info-basic';

Future<List<RestaurantModelo>> getRestaurants(String tokenUser) async {
  final List<RestaurantModelo> lista = [];

  final response = await http.post(Uri.parse(url), headers: {
    "Authorization": "Bearer $tokenUser",
    'Accept': 'application/json'
  });
  print(response.statusCode);
  String body = utf8.decode(response.bodyBytes);
  //debugPrint(body);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(body);
    for (var value in data) {
      RestaurantModelo restaurantModelo = RestaurantModelo.fromJson(value);
      lista.add(restaurantModelo);
    }
  }
  if (response.statusCode == 403) {
    RestaurantModelo restaurantModelo = RestaurantModelo(
        statusCode: 403, message: 'Compre una suscripción primero.');
    lista.add(restaurantModelo);
  }
  return lista;
}

Future<RestaurantModelo> getRestaurant(String tokenUser, int id) async {
  String url = '${Config.baseUrl}/api/restaurant/get-restaurant';
  final response = await http.post(
    Uri.parse(url),
    headers: {
      "Authorization": "Bearer $tokenUser",
      'Accept': 'application/json'
    },
    body: {
      'id': id.toString(),
    },
  );
  print(response.statusCode);
  String body = utf8.decode(response.bodyBytes);
  debugPrint(body);
  final data = restaurantModeloFromJson(body);
  data.statusCode = response.statusCode;
  return data;
}

Future<RestaurantModelo> updateRestaurantInfoBasic(
    String tokenUser, RestaurantModelo info, int id) async {
  String url = '${Config.baseUrl}/api/restaurant/update-info-basic';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      "Authorization": "Bearer $tokenUser",
      'Accept': 'application/json'
    },
    body: {
      'id': id.toString(),
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

Future<RestaurantModelo> createRestaurant(
  String tokenUser,
  RestaurantModelo info,
) async {
  String url = '${Config.baseUrl}/api/restaurant/create-new-restaurant';

  await Future.delayed(const Duration(seconds: 3));
  final response = await http.post(
    Uri.parse(url),
    headers: {
      "Authorization": "Bearer $tokenUser",
      'Accept': 'application/json'
    },
    body: {
      'restaurant': info.restaurant,
    },
  );
  String body = utf8.decode(response.bodyBytes);
  debugPrint(body);
  final data = restaurantModeloFromJson(body);
  data.statusCode = response.statusCode;
  return data;
}

Future<AuthModelo> deleteRestaurant(
  String tokenUser,
  RestaurantModelo info,
  String password,
) async {
  String url = '${Config.baseUrl}/api/restaurant/delete-restaurant';

  await Future.delayed(const Duration(seconds: 3));
  final response = await http.post(
    Uri.parse(url),
    headers: {
      "Authorization": "Bearer $tokenUser",
      'Accept': 'application/json'
    },
    body: {
      'id': info.id_restaurant.toString(),
      'password': password,
    },
  );
  String body = utf8.decode(response.bodyBytes);
  debugPrint(body);
  final data = authModeloFromJson(body);
  data.statusCode = response.statusCode;
  return data;
}
