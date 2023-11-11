import 'dart:convert';

import 'package:baseapp/modelos/autenticacion_model.dart';
import 'package:http/http.dart' as http;

String url = 'https://0fb7-187-171-251-22.ngrok-free.app/api/register';

Future<AuthModelo> registerUser(
    String email, String password, String username) async {
  await Future.delayed(const Duration(seconds: 3));
  final response = await http.post(Uri.parse(url),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password, 'username': username});
  String body = utf8.decode(response.bodyBytes);
  final jsonData = authModeloFromJson(body);
  jsonData.statusCode = response.statusCode;
  print(body);
  print(response.statusCode);
  return jsonData;
}
