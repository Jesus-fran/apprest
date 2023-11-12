import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hola"),
      // child: ElevatedButton(
      //   onPressed: () {
      //     // Agrega aquí la lógica que desees para el contenido principal de Home
      //     print("Botón presionado en HomeContent");
      //   },
      //   child: const Text("Contenido Principal de Home"),
      // ),
    );
  }
}
