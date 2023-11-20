import 'package:baseapp/controladores/payment_controller.dart';
import 'package:baseapp/modelos/payment_model.dart';
import 'package:baseapp/vistas/home_pages.dart';
import 'package:flutter/material.dart';

class SuscribiendoUser extends StatefulWidget {
  final String tokenUser;
  final String plan;
  final bool cardNew;
  const SuscribiendoUser(
      {super.key,
      required this.tokenUser,
      required this.plan,
      required this.cardNew});

  @override
  State<SuscribiendoUser> createState() => _SuscribiendoUserState();
}

class _SuscribiendoUserState extends State<SuscribiendoUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: FutureBuilder<PaymentModel>(
              future: widget.cardNew
                  ? tokenizarCard(widget.tokenUser, widget.plan)
                  : suscribeUser('token_vacio', widget.tokenUser, widget.plan),
              builder: (context, AsyncSnapshot<PaymentModel> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.status) {
                    // Si se suscribe correctamente
                    return succesMessage(context, snapshot.data!.message);
                  } else {
                    // Si hubo un fallo al suscribirse
                    return errorMessage(context, snapshot.data!.message);
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
        Text('Procesando suscripción..',
            style:
                TextStyle(fontSize: 30, color: Color.fromRGBO(47, 79, 79, 1))),
        SizedBox(height: 60),
        LinearProgressIndicator(
          color: Colors.amberAccent,
        ),
        SizedBox(height: 60),
        Text(
          'Espere un momento, por favor.',
          style: TextStyle(fontSize: 25, color: Color.fromRGBO(47, 79, 79, 1)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget errorMessage(context, message) {
    void showAutoSnackBar(BuildContext context) {
      // Muestra msg de error
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

  Widget succesMessage(BuildContext context, String message) {
    void showAutoSnackBar(BuildContext context) {
      // Muestra msg de success
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnackBar snack_1 = SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.greenAccent, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 15),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack_1);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePages()),
          (route) => false);
    });
    showAutoSnackBar(context);

    return Container();
  }
}
