import 'dart:convert';

import 'package:http/http.dart' as http;

String url = 'http://192.168.1.103:8000/api/rest';

Future<void> getPost() async {
  final response =
      await http.get(Uri.parse(url), headers: {'Accept': 'application/json'});

  String body = utf8.decode(response.bodyBytes);
  final jsonData = jsonDecode(body);
  print(response.statusCode);
  print(jsonData['message']);
}
