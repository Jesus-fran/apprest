import 'dart:convert';

import 'package:baseapp/modelos/register_model.dart';
import 'package:http/http.dart' as http;

String url = 'http://192.168.1.103:8000/api/login';

Future<RegisterModelo> loginUser(
    String email, String password) async {
  await Future.delayed(const Duration(seconds: 3));
  final response = await http.post(Uri.parse(url),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password});
  String body = utf8.decode(response.bodyBytes);
  final jsonData = registerModeloFromJson(body);
  jsonData.statusCode = response.statusCode;
  print(body);
  print(response.statusCode);
  return jsonData;
}
