import 'package:baseapp/modelos/register_model.dart';
import 'package:baseapp/modelos/user_model.dart';
import 'package:baseapp/vistas/home.dart';
import 'package:flutter/material.dart';
import 'package:baseapp/controladores/registro.dart';

class Cargando extends StatefulWidget {
  final UserModelo usuario;
  const Cargando({super.key, required this.usuario});
  @override
  State<Cargando> createState() => _CargandoState();
}

class _CargandoState extends State<Cargando> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: FutureBuilder<RegisterModelo>(
              future: registerUser(widget.usuario.email,
                  widget.usuario.password, widget.usuario.username),
              builder: (context, AsyncSnapshot<RegisterModelo> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.statusCode == 200 &&
                      snapshot.data!.status) {
                    //Si se registra correctamente
                    return succesMessage(context);
                  } else if (snapshot.data!.statusCode == 200 &&
                      !snapshot.data!.status) {
                    //Si hubo un fallo al registrar
                    return errorMessage(context);
                  } else if (snapshot.data!.statusCode == 422) {
                    //Si hubo un error de validación
                    return validationMessage(snapshot.data!.message, context);
                  } else {
                    //Si hay un error desconocido
                    return errorMessage(context);
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
      Text('Registrando..', style: TextStyle(fontSize: 30)),
      SizedBox(height: 60),
      LinearProgressIndicator(
        color: Colors.redAccent,
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
        'Hubo un error al intentar registrarte',
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

Widget succesMessage(context) {
  return Column(
    children: [
      const SizedBox(height: 150),
      const Text('Registrado correctamente..', style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
      const SizedBox(height: 60),
      const Icon(Icons.sentiment_satisfied_alt, size: 50),
      const SizedBox(height: 50),
      ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
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
