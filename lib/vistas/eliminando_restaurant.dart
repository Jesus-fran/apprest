import 'package:baseapp/controladores/restaurant_controller.dart';
import 'package:baseapp/modelos/autenticacion_model.dart';
import 'package:baseapp/modelos/restaurant_model.dart';
import 'package:baseapp/vistas/home_pages.dart';
import 'package:flutter/material.dart';

class EliminandoRestaurant extends StatefulWidget {
  final String tokenUser;
  final RestaurantModelo info;
  final String password;
  const EliminandoRestaurant(
      {super.key,
      required this.tokenUser,
      required this.info,
      required this.password});
  @override
  State<EliminandoRestaurant> createState() => _EliminandoRestaurantState();
}

class _EliminandoRestaurantState extends State<EliminandoRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: FutureBuilder<AuthModelo>(
              future: deleteRestaurant(
                  widget.tokenUser, widget.info, widget.password),
              builder: (context, AsyncSnapshot<AuthModelo> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.statusCode == 200 &&
                      snapshot.data!.status) {
                    //Si guarda correctamente
                    return succesMessage(context, snapshot.data!.message);
                  } else if (snapshot.data!.statusCode == 200 &&
                      !snapshot.data!.status) {
                    //Si hubo un fallo al guardar
                    return errorMessage(context, snapshot.data!.message);
                  } else if (snapshot.data!.statusCode == 422) {
                    //Si hubo un error de validación
                    return validationMessage(snapshot.data!.message, context);
                  } else {
                    //Si hay un error desconocido
                    return errorMessage(context,
                        'Hubo un error al intentar eliminar el restaurante.');
                  }
                } else {
                  return cargandoMessage(context);
                }
              }),
        ),
      ),
    );
  }

  Widget cargandoMessage(context) {
    return const Column(
      children: [
        SizedBox(height: 200),
        Text(
          'Eliminando restaurante..',
          style: TextStyle(
              fontSize: 30,
              color: Color.fromRGBO(47, 79, 79, 1),
              fontWeight: FontWeight.w500),
        ),
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
    void showAutoSnackBar(BuildContext context) {
      // Muestra si hay un error de validación
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnackBar snack_1 = SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.redAccent, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 15),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack_1);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
      Navigator.pop(context);
    });

    showAutoSnackBar(context);

    return Container();
  }

  Widget errorMessage(context, message) {
    void showAutoSnackBar(BuildContext context) {
      // Muestra si hay un error de validación
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnackBar snack_1 = SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.redAccent, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 15),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack_1);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
      Navigator.pop(context);
    });

    showAutoSnackBar(context);

    return Container();
  }

  Widget succesMessage(context, message) {
    void showAutoSnackBar(BuildContext context) {
      // Muestra si todo fue bien
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnackBar snack_1 = SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 10),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack_1);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) =>  HomePages(
                    initialIndex: 2,
                  )),
          (route) => false);
    });

    showAutoSnackBar(context);

    return Container();
  }
}
