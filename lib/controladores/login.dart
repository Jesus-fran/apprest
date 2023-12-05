import 'dart:convert';

import 'package:PerfectConnection/modelos/autenticacion_model.dart';
import 'package:http/http.dart' as http;
import 'package:PerfectConnection/config.dart';

String url = '${Config.baseUrl}/api/login';

Future<AuthModelo> loginUser(String email, String password) async {
  print(url);
  await Future.delayed(const Duration(seconds: 3));
  final response = await http.post(Uri.parse(url),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password});
  String body = utf8.decode(response.bodyBytes);
  print(body);
  final jsonData = authModeloFromJson(body);
  jsonData.statusCode = response.statusCode;
  return jsonData;
}
