import 'package:PerfectConnection/vistas/suscribiendo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive/hive.dart';

class FormularioPago extends StatefulWidget {
  final String plan;
  const FormularioPago({super.key, required this.plan});

  @override
  State<FormularioPago> createState() => _FormularioPagoState();
}

class _FormularioPagoState extends State<FormularioPago> {
  final controller = CardFormEditController();
  String errorMessage = '';
  late final Box box;
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordHidden = true;

  @override
  void initState() {
    controller.addListener(update);
    box = Hive.box('tokenBox');
    super.initState();
  }

  void update() => setState(() {});
  @override
  void dispose() {
    controller.removeListener(update);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF854),
        title: const Text(
          'Agregar metodo de pago',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.add_card),
          ),
        ],
      ),
      body: content(),
    );
  }

  Widget content() {
    void showAutoSnackBar(BuildContext context) {
      // Muestra si hay un error de validación
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnackBar snack_1 = SnackBar(
          content: Text(
            errorMessage,
            style: const TextStyle(color: Colors.redAccent, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack_1);
      });
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            CardFormField(
              controller: controller,
              enablePostalCode: true,
              countryCode: 'MX',
              style: CardFormStyle(
                  fontSize: 18,
                  borderColor: Colors.black,
                  textColor: Colors.black,
                  placeholderColor: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Por seguridad, debes ingresar tu contraseña para proceder con la suscripción.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formfield,
                child: TextFormField(
                  maxLength: 30,
                  controller: _passwordController,
                  obscureText: passwordHidden,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.asset('assets/password.png',
                          width: 20, height: 20),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        //passwordHidden = !passwordHidden;
                        setState(() {
                          passwordHidden = !passwordHidden;
                        });
                        //updateState();
                      },
                      child: Icon(passwordHidden
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    hintText: "Contraseña",
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    bool passInvalid = RegExp(
                            r"^(?=.*[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ])(?=.*\d)(?=.*[@$!%*?&^#/_.;\s:-])[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ\d@$!%*?&^#/_.;\s:-]+$")
                        .hasMatch(value!);
                    if (value.isEmpty) {
                      return "Ingrese una contraseña";
                    } else if (value.length < 6) {
                      return "Al menos ingrese 6 caracteres.";
                    } else if (!passInvalid) {
                      return "Al menos una minúscula o mayúscula, un número y un caracter.";
                    } else {
                      return null;
                    }
                  },
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                var token = box.get('token');
                if (!validation()) {
                  if (_formfield.currentState!.validate()) {
                    debugPrint('very ok');
                    String password = _passwordController.text;
                    _passwordController.clear();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SuscribiendoUser(
                                tokenUser: token,
                                plan: widget.plan,
                                cardNew: true,
                                password: password,
                              )),
                    );
                  }
                } else {
                  showAutoSnackBar(context);
                }
              },
              style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFFFF854),
                  foregroundColor: Colors.black,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
              child: const Text('Agregar tarjeta'),
            ),
          ],
        ),
      ),
    );
  }

  bool validation() {
    if (!controller.details.complete) {
      setState(() {
        errorMessage = 'Ingrese los datos de su tarjeta';
      });
      return true;
    }

    if (controller.details.postalCode == '') {
      setState(() {
        errorMessage = 'Debe ingresar un código postal';
      });
      return true;
    }

    if (int.tryParse(controller.details.postalCode.toString()) == null) {
      setState(() {
        errorMessage = 'El código postal debe tener solo números';
      });
      return true;
    }

    if (controller.details.postalCode!.length < 5 ||
        controller.details.postalCode!.length > 5) {
      setState(() {
        errorMessage = 'Código postal incorrecto';
      });
      return true;
    }
    return false;
  }
}
