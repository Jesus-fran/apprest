import 'dart:convert';
import 'package:PerfectConnection/config.dart';
import 'package:PerfectConnection/modelos/autenticacion_model.dart';
import 'package:PerfectConnection/modelos/restaurant_model.dart';
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

Future<List<RestaurantModelo>> getAllRestaurants(String tokenUser) async {
  final List<RestaurantModelo> lista = [];
  String url = '${Config.baseUrl}/api/restaurant/get-all-restaurants';

  final response = await http.get(Uri.parse(url), headers: {
    "Authorization": "Bearer $tokenUser",
    'Accept': 'application/json'
  });
  print(response.statusCode);
  String body = utf8.decode(response.bodyBytes);
  print(body);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(body);
    for (var value in data) {
      RestaurantModelo restaurantModelo = RestaurantModelo.fromJson(value);
      lista.add(restaurantModelo);
    }
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

Future<RestaurantModelo> getProfileRestaurant(String tokenUser, int id) async {
  String url = '${Config.baseUrl}/api/restaurant/get-profile-restaurant';
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

Future<List<RestaurantModelo>> getFilterRestaurant(
    String tokenUser, String tipo) async {
  final List<RestaurantModelo> lista = [];
  String url = '${Config.baseUrl}/api/restaurant/get-filter-restaurants';

  final response = await http.post(Uri.parse(url), headers: {
    "Authorization": "Bearer $tokenUser",
    'Accept': 'application/json'
  }, body: {
    "tipo": tipo
  });
  print(response.statusCode);
  String body = utf8.decode(response.bodyBytes);
  print(body);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(body);
    for (var value in data) {
      RestaurantModelo restaurantModelo = RestaurantModelo.fromJson(value);
      lista.add(restaurantModelo);
    }
  }
  return lista;
}

Future<List<RestaurantModelo>> getSearchRestaurant(
    String tokenUser, String busqueda) async {
  final List<RestaurantModelo> lista = [];
  String url = '${Config.baseUrl}/api/restaurant/get-search-restaurants';

  final response = await http.post(Uri.parse(url), headers: {
    "Authorization": "Bearer $tokenUser",
    'Accept': 'application/json'
  }, body: {
    "busqueda": busqueda
  });
  String body = utf8.decode(response.bodyBytes);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(body);
    for (var value in data) {
      RestaurantModelo restaurantModelo = RestaurantModelo.fromJson(value);
      lista.add(restaurantModelo);
    }
  }
  if (response.statusCode == 422) {
    final data = restaurantModeloFromJson(body);
    data.statusCode = response.statusCode;
    lista.add(data);
  }
  return lista;
}

Future<RestaurantModelo> updateMenu(
    String tokenUser, RestaurantModelo info, int id) async {
  String url = '${Config.baseUrl}/api/restaurant/update-menu';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      "Authorization": "Bearer $tokenUser",
      'Accept': 'application/json'
    },
    body: {
      'id': id.toString(),
      'oferta': info.oferta,
      'desc_oferta': info.descOferta,
    },
  );
  String body = utf8.decode(response.bodyBytes);
  debugPrint(body);
  final data = restaurantModeloFromJson(body);
  data.statusCode = response.statusCode;
  return data;
}

Future<RestaurantModelo> updateUbicacion(
    String tokenUser, RestaurantModelo info, int id) async {
  String url = '${Config.baseUrl}/api/restaurant/update-ubicacion';

  final response = await http.post(
    Uri.parse(url),
    headers: {
      "Authorization": "Bearer $tokenUser",
      'Accept': 'application/json'
    },
    body: {
      'id': id.toString(),
      'ubicacion': info.ubicacion,
    },
  );
  String body = utf8.decode(response.bodyBytes);
  debugPrint(body);
  final data = restaurantModeloFromJson(body);
  data.statusCode = response.statusCode;
  return data;
}

Future<dynamic> getUbicacion(String tokenUser, int id) async {
  String url = '${Config.baseUrl}/api/restaurant/ubicacion';

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
  String body = utf8.decode(response.bodyBytes);
  debugPrint(body);
  final List<dynamic> dataList = json.decode(body);
  return dataList;
}
