import 'package:baseapp/controladores/recuperar_password_controller.dart';
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
          child: FutureBuilder<bool>(
              future: recuperarPassword(widget.email),
              builder: (context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  return succesMessage(context);
                } else {
                  return enviandoMessage(context);
                }
              }),
        ),
      ),
    );
  }

  Widget succesMessage(BuildContext context) {
    void showAutoSnackBar(BuildContext context) {
      // Muestra si hay un error de validación
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnackBar snack_1 = const SnackBar(
          content: Text(
            'Correo de recuperación enviado con éxito. Revisa tu correo',
            style: TextStyle(color: Colors.greenAccent, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 25),
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
        Text('Enviando correo de recuperación..',
            style: TextStyle(fontSize: 30), textAlign: TextAlign.center,),
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
}
