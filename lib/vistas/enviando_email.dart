import 'package:baseapp/controladores/recuperar_password_controller.dart';
import 'package:baseapp/modelos/autenticacion_model.dart';
import 'package:flutter/material.dart';

class EnviandoEmail extends StatefulWidget {
  final String email;
  const EnviandoEmail({super.key, required this.email});
  @override
  State<EnviandoEmail> createState() => _EnviandoEmailState();
}

class _EnviandoEmailState extends State<EnviandoEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: FutureBuilder<AuthModelo>(
              future: recuperarPassword(widget.email),
              builder: (context, AsyncSnapshot<AuthModelo> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.statusCode == 200 &&
                      snapshot.data!.status) {
                    //Si envia el email correctamente
                    return succesMessage(context, snapshot.data!.message);
                  } else if (snapshot.data!.statusCode == 200 &&
                      !snapshot.data!.status) {
                    //Si hubo un fallo al enviar el email
                    return errorMessage(context, snapshot.data!.message);
                  } else if (snapshot.data!.statusCode == 422) {
                    //Si hubo un error de validación
                    return validationMessage(snapshot.data!.message, context);
                  } else {
                    //Si hay un error desconocido
                    return errorMessage(context,
                        'Hubo un error al intentar enviar el correo de recuperación.');
                  }
                } else {
                  return enviandoMessage(context);
                }
              }),
        ),
      ),
    );
  }

  Widget succesMessage(BuildContext context, message) {
    void showAutoSnackBar(BuildContext context) {
      // Muestra si hay un error de validación
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnackBar snack_1 = SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 25),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack_1);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
    });

    showAutoSnackBar(context);
    return Container();
  }

  Widget enviandoMessage(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 200),
        Text(
          'Enviando correo de recuperación..',
          style: TextStyle(
              fontSize: 30,
              color: Color.fromRGBO(47, 79, 79, 1),
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 60),
        LinearProgressIndicator(
          color: Color.fromRGBO(255, 92, 27, 0.692),
        ),
        SizedBox(height: 60),
        Text(
          'Espere un momento, por favor.',
          style: TextStyle(fontSize: 25, color: Color.fromRGBO(47, 79, 79, 1), fontWeight: FontWeight.w400),
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
    });

    showAutoSnackBar(context);

    return Container();
  }
}
