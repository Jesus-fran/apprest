import 'dart:convert';

import 'package:PerfectConnection/config.dart';
import 'package:PerfectConnection/modelos/autenticacion_model.dart';
import 'package:http/http.dart' as http;

String url = '${Config.baseUrl}/api/register';

Future<AuthModelo> registerUser(
    String email, String password, String username) async {
  await Future.delayed(const Duration(seconds: 3));
  final response = await http.post(Uri.parse(url),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password, 'username': username});
  String body = utf8.decode(response.bodyBytes);
  final jsonData = authModeloFromJson(body);
  jsonData.statusCode = response.statusCode;
  return jsonData;
}
