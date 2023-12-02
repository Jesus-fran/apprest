import 'dart:convert';
import 'package:baseapp/config.dart';
import 'package:baseapp/modelos/payment_model.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

String url = '${Config.baseUrl}/api/suscribe';

Future<PaymentModel> suscribeUser(
    String tokenCard, String tokenUser, String plan, String password) async {
  final response = await http.post(Uri.parse(url), headers: {
    "Authorization": "Bearer $tokenUser",
    'Accept': 'application/json'
  }, body: {
    'tokenCard': tokenCard,
    'plan': plan,
    'password': password,
  });
  String body = utf8.decode(response.bodyBytes);
  print(body);
  final jsonData = paymentModelFromJson(body);
  return jsonData;
}

Future<PaymentModel> tokenizarCard(
    String tokenUser, String plan, String password) async {
  const billingDetails = BillingDetails();

  // Create payment method
  final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: const PaymentMethodParams.card(
    paymentMethodData: PaymentMethodData(
      billingDetails: billingDetails,
    ),
  ));

  print(paymentMethod);
  final suscribeResp =
      suscribeUser(paymentMethod.id, tokenUser, plan, password);
  return suscribeResp;
}
