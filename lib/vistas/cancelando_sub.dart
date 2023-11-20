import 'package:baseapp/controladores/cancel_plan_controller.dart';
import 'package:baseapp/modelos/plan_model.dart';
import 'package:baseapp/vistas/home_pages.dart';
import 'package:flutter/material.dart';

class CancelandoSub extends StatefulWidget {
  final String tokenUser;
  const CancelandoSub({
    super.key,
    required this.tokenUser,
  });

  @override
  State<CancelandoSub> createState() => _CancelandoSubState();
}

class _CancelandoSubState extends State<CancelandoSub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: FutureBuilder<PlanModel>(
              future: cancelSubscription(widget.tokenUser),
              builder: (context, AsyncSnapshot<PlanModel> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.status) {
                    // Si se cancela correctamente
                    return succesMessage(context, snapshot.data!.message);
                  } else {
                    // Si hubo un fallo al cancelar la subscripción
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
        Text('Cancelando suscripción..',
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
          MaterialPageRoute(
              builder: (context) => const HomePages(
                    initialIndex: 1,
                  )),
          (route) => false);
    });
    showAutoSnackBar(context);

    return Container();
  }
}
