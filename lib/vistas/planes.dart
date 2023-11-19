import 'package:baseapp/controladores/current_plan_controller.dart';
import 'package:baseapp/modelos/plan_model.dart';
import 'package:baseapp/vistas/cancelando_sub.dart';
import 'package:baseapp/vistas/formulario_pago.dart';
import 'package:baseapp/vistas/suscribiendo.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Planes extends StatelessWidget {
  const Planes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('tokenBox');
    var tokenUser = box.get('token');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: FutureBuilder<PlanModel>(
              future: currentPlan(tokenUser),
              builder: (context, AsyncSnapshot<PlanModel> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.status &&
                      snapshot.data!.statusCode == 200) {
                    // Si obtiene los datos correctamente
                    return succesMessage(context, snapshot.data!.plan,
                        snapshot.data!.card, tokenUser);
                  } else {
                    // Si hubo un fallo al obtener datos
                    return errorMessage(context,
                        "Hubo un error al conectarse con el servidor.");
                  }
                } else {
                  return cargandoMessage(context);
                }
              }),
        ),
      ),
    );
  }

  Widget succesMessage(
      BuildContext context, String plan, bool card, String tokenUser) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '¡Bienvenido! a la sección de crear Restaurante. Para continuar elija el tipo de plan que desea adquirir.',
            style: TextStyle(
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Divider(
          height: 50,
          color: Colors.transparent,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 25.0), // para el margen izquiero
          child: Text(
            'Nuestros planes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        RefreshIndicator(
          child: Column(
            children: [
              MyCard(
                title: 'Basico mensual',
                subtitle: 'Beneficios',
                subitems: const [
                  'Listado en la plataforma',
                  'Espacios rotativos de publicidad',
                  'Soporte por correo'
                ],
                buttonText: plan == 'basicomen' ? 'Cancelar' : 'Suscribirme',
                onPressed: () {
                  if (plan == 'basicomen') {
                    _showDialogCancel(
                        context,
                        '¿Estas seguro de terminar tu plan basico mensual?',
                        tokenUser);
                    return;
                  }
                  if (card) {
                    print('Tienes una tarjeta registrada');
                    _showDialogSuscribirse(
                        context,
                        '¿Quieres suscribirte al plan basico mensual?',
                        tokenUser,
                        'basicomen');
                  } else {
                    print('No tienes tarjeta');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FormularioPago(plan: 'basicomen'),
                        ));
                  }
                },
                buttonColor: plan == 'basicomen' ? Colors.red : Colors.black,
                buttonTextColor: Colors.white,
              ),
              MyCard(
                title: 'Basico anual',
                subtitle: 'Beneficios',
                subitems: const ['xd', 'xd', 'xd'],
                buttonText: plan == 'basicoanual' ? 'Cancelar' : 'Suscribirme',
                onPressed: () {
                  if (plan == 'basicoanual') {
                    _showDialogCancel(
                        context,
                        '¿Estas seguro de terminar tu plan basico anual?',
                        tokenUser);
                    return;
                  }
                  if (card) {
                    print('Tienes una tarjeta registrada');
                    _showDialogSuscribirse(
                        context,
                        '¿Quieres suscribirte al plan basico anual?',
                        tokenUser,
                        'basicoanual');
                  } else {
                    print('No tienes tarjeta');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FormularioPago(plan: 'basicoanual'),
                        ));
                  }
                },
                buttonColor: plan == 'basicoanual' ? Colors.red : Colors.black,
                buttonTextColor: Colors.white,
              ),
              MyCard(
                title: 'Premium mensual',
                subtitle: 'Beneficios',
                subitems: const ['xd', 'xd', 'xd'],
                buttonText: plan == 'premiummen' ? 'Cancelar' : 'Suscribirme',
                onPressed: () {
                  if (plan == 'premiummen') {
                    _showDialogCancel(
                        context,
                        '¿Estas seguro de terminar tu plan premium mensual?',
                        tokenUser);
                    return;
                  }
                  if (card) {
                    print('Tienes una tarjeta registrada');
                    _showDialogSuscribirse(
                        context,
                        '¿Quieres suscribirte al plan premium mensual?',
                        tokenUser,
                        'premiummen');
                  } else {
                    print('No tienes tarjeta');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FormularioPago(plan: 'premiummen'),
                        ));
                  }
                },
                buttonColor: plan == 'premiummen' ? Colors.red : Colors.black,
                buttonTextColor: Colors.white,
              ),
              MyCard(
                title: 'Premium anual',
                subtitle: 'Subtitulo 3',
                subitems: const ['xd', 'xd', 'xd'],
                buttonText: plan == 'premiumanual' ? 'Cancelar' : 'Suscribirme',
                onPressed: () {
                  if (plan == 'premiumanual') {
                    _showDialogCancel(
                        context,
                        '¿Estas seguro de terminar tu plan premium anual?',
                        tokenUser);
                    return;
                  }
                  if (card) {
                    print('Tienes una tarjeta registrada');
                    _showDialogSuscribirse(
                        context,
                        '¿Quieres suscribirte al plan premium anual?',
                        tokenUser,
                        'premiumanual');
                  } else {
                    print('No tienes tarjeta');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FormularioPago(plan: 'premiumanual'),
                        ));
                  }
                },
                buttonColor: plan == 'premiumanual' ? Colors.red : Colors.black,
                buttonTextColor: Colors.white,
              ),
            ],
          ),
          onRefresh: () {
            return Future<void>(() {
              debugPrint("Actualiza pantalla");
            });
          },
        ),
      ],
    );
  }

  Widget cargandoMessage(context) {
    return const Column(
      children: [
        SizedBox(height: 200),
        CircularProgressIndicator(
          color: Colors.amberAccent,
        ),
        SizedBox(height: 60),
      ],
    );
  }

  Widget errorMessage(context, message) {
    return Column(
      children: [
        const SizedBox(height: 200),
        Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 60),
      ],
    );
  }

  Future<void> _showDialogCancel(
      BuildContext context, String msg, String tokenUser) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(msg),
            content: const Text(
                'Tu restaurante dejará de estar disponible, hasta que realices una nueva suscripción.'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 228, 228, 228),
                        foregroundColor: Colors.black,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    child: const Center(child: Text("Cerrar")),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 245, 69, 69),
                        foregroundColor: Colors.white,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CancelandoSub(tokenUser: tokenUser),
                          ));
                      print('Cancelando suscripción...');
                    },
                    child: const Center(child: Text("Terminar plan")),
                  ),
                ],
              )
            ],
          );
        });
  }

  Future<void> _showDialogSuscribirse(
      BuildContext context, String msg, String tokenUser, String plan) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(msg),
            content: const Text(
                'Recuerda que para pagar esta suscripción utilizaremos tu método de pago que tienes predeterminado.'),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 228, 228, 228),
                        foregroundColor: Colors.black,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    child: const Center(child: Text("Cerrar")),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 245, 69, 69),
                        foregroundColor: Colors.white,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuscribiendoUser(
                                tokenUser: tokenUser,
                                plan: plan,
                                cardNew: false),
                          ));
                    },
                    child: const Center(child: Text("Suscribirme")),
                  ),
                ],
              )
            ],
          );
        });
  }
}

class MyCard extends StatelessWidget {
  // Propiedades
  final String title;
  final String subtitle;
  final List<String> subitems;
  final String buttonText;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color buttonTextColor;

  const MyCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.subitems,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    required this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    const double titleFontSize = 22.0;
    const double subtitleFontSize = 15.0;
    const double subitemsFontSize = 12.0;

    return Card(
      margin: const EdgeInsets.all(25.0),
      color: const Color.fromARGB(255, 255, 252, 161),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // redondear bordrs
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: subtitleFontSize,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subitems
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '• $item',
                          style: const TextStyle(
                            fontSize: subitemsFontSize,
                            height: 1.2,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: buttonTextColor,
                  backgroundColor: buttonColor,
                ),
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
