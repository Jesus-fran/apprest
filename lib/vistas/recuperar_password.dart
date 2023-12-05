import 'package:PerfectConnection/vistas/enviando_email.dart';
import 'package:flutter/material.dart';

class RecuperarPassword extends StatefulWidget {
  const RecuperarPassword({super.key});

  @override
  State<RecuperarPassword> createState() => _RecuperarPasswordState();
}

class _RecuperarPasswordState extends State<RecuperarPassword> {
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _enviarEmail() {
    final email = _emailController.text;
    _emailController.text = '';
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => EnviandoEmail(email: email)));
    debugPrint("Correo: $email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF854),
        title: const Text(
          'Recuperar contraseña',
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/usuario.png', width: 40),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formfield,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Text('¿Cuál es tu correo?',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4.0),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(6),
                    child:
                        Image.asset('assets/correo.png', width: 20, height: 20),
                  ),
                  hintText: "Ingresa tu correo",
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  bool nameValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~ñÑáéíóúÁÉÍÓÚ]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);
                  if (value.isEmpty) {
                    return "Ingrese su correo electrónico";
                  } else if (!nameValid) {
                    return "Su correo no es valido";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 30),
              const Text(
                  'Te enviaremos un correo para que puedas restablecer tu contraseña de manera segura.',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.black)),
              const SizedBox(height: 30),
              ConstrainedBox(
                constraints:
                    const BoxConstraints.tightFor(height: 50, width: 500),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formfield.currentState!.validate()) {
                      debugPrint("Validado correctamente");
                      _enviarEmail();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFFFFF854)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Continuar",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
