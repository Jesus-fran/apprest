import 'package:baseapp/controladores/login.dart';
import 'package:baseapp/modelos/autenticacion_model.dart';
import 'package:baseapp/modelos/usuario_model.dart';
import 'package:baseapp/vistas/home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Logueando extends StatefulWidget {
  final UserModelo usuario;
  const Logueando({super.key, required this.usuario});
  @override
  State<Logueando> createState() => _LogueandoState();
}

class _LogueandoState extends State<Logueando> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: FutureBuilder<AuthModelo>(
              future: loginUser(widget.usuario.email, widget.usuario.password),
              builder: (context, AsyncSnapshot<AuthModelo> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.statusCode == 200 &&
                      snapshot.data!.status) {
                    //Si se loguea correctamente
                    return succesMessage(context, snapshot.data!.token);
                  } else if (snapshot.data!.statusCode == 200 &&
                      !snapshot.data!.status) {
                    //Si hubo un fallo al loguear
                    return errorMessage(context, snapshot.data!.message);
                  } else if (snapshot.data!.statusCode == 422) {
                    //Si hubo un error de validación
                    return validationMessage(snapshot.data!.message, context);
                  } else {
                    //Si hay un error desconocido
                    return errorMessage(
                        context, 'Hubo un error al intentar iniciar sesión');
                  }
                } else {
                  return cargandoMessage(context);
                }
              }),
        ),
      ),
    );
  }
}

Widget cargandoMessage(context) {
  return const Column(
    children: [
      SizedBox(height: 200),
      Text('Iniciando sesión..', style: TextStyle(fontSize: 30)),
      SizedBox(height: 60),
      LinearProgressIndicator(
        color: Colors.amberAccent,
      ),
      SizedBox(height: 60),
      Text(
        'Espere un momento, por favor.',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget validationMessage(String message, context) {
  return Column(
    children: [
      const SizedBox(height: 150),
      const Text('Algo ocurrió..', style: TextStyle(fontSize: 30)),
      const SizedBox(height: 60),
      const Icon(Icons.sentiment_dissatisfied, size: 50),
      const SizedBox(height: 60),
      Text(
        message,
        style: const TextStyle(fontSize: 25),
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

Widget errorMessage(context, message) {
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
      Text(
        message,
        style: const TextStyle(fontSize: 25),
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

Widget succesMessage(context, token) {
  var box = Hive.box('tokenBox');
  box.put('token', token);

  // Con WidgetsBinding.instance.addPostFrameCallback() evitamos que ocurra un error
  // al intentar redirigir a una interfaz desde el builder, aseguramos que eso ocurra
  // hasta que se haya construido todo.
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  });

  return Container();
}
