import 'package:baseapp/vistas/home.dart';
import 'package:flutter/material.dart';

class LogueandoTwitter extends StatefulWidget {
  final String username;
  final bool status;
  const LogueandoTwitter(
      {super.key, required this.username, required this.status});

  @override
  State<LogueandoTwitter> createState() => _LogueandoTwitterState();
}

class _LogueandoTwitterState extends State<LogueandoTwitter> {
  @override
  Widget build(BuildContext context) {
    if (widget.status) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: succesMessage(context, widget.username),
        ))
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: errorMessage(context),
        ))
      );
  }
}

Widget errorMessage(context) {
  return Column(
    children: [
      const SizedBox(height: 150),
      const Text('Algo ocurrió..', style: TextStyle(fontSize: 30)),
      const SizedBox(height: 60),
      const Icon(
        Icons.error,
        size: 50,
        color: Colors.redAccent,
      ),
      const SizedBox(height: 60),
      const Text(
        'Hubo un error al iniciar sesión con tu cuenta de Twitter',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 50),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 255, 156, 98)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: const Text(
          "Intentar de nuevo",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

Widget succesMessage(context, username) {
  String saludo = "Hola $username";
  return Column(
    children: [
      const SizedBox(height: 150),
      Text(
        saludo,
        style: const TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 60),
      const Text(
        'Iniciaste sesión correctamente..',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 60),
      const Icon(Icons.sentiment_satisfied_alt, size: 50),
      const SizedBox(height: 50),
      ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false,
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 255, 239, 98)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: const Text(
          "Continuar",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
