import 'dart:convert';
import 'package:PerfectConnection/config.dart';
import 'package:PerfectConnection/modelos/plan_model.dart';
import 'package:http/http.dart' as http;

String url = '${Config.baseUrl}/api/cancel-subscription';

Future<PlanModel> cancelSubscription(String tokenUser, String password) async {
  final response = await http.post(Uri.parse(url), headers: {
    "Authorization": "Bearer $tokenUser",
    'Accept': 'application/json'
  }, body: {
    'password': password,
  });
  String body = utf8.decode(response.bodyBytes);
  print(body);
  final jsonData = planModelFromJson(body);
  jsonData.statusCode = response.statusCode;
  return jsonData;
}
