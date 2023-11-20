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
        const Text(
          'Nuestros planes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          '¿Eres restaurantero y quieres mejores ingresos o mayor visibilidad?',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Entonces elige un plan y accede a muchos beneficios.',
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Icon(
              Icons.looks_one_rounded,
              color: Color.fromARGB(255, 138, 8, 161),
            ),
            SizedBox(
              width: 10,
            ),
            Text('Elige una suscripción', style: TextStyle(fontSize: 16)),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.looks_two_rounded,
              color: Colors.blue[900],
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('Realiza el pago correspondiente',
                style: TextStyle(fontSize: 16)),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.looks_3_rounded,
              color: Colors.green[600],
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('Haz público tu restaurante',
                style: TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '¡Comienza hoy!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
        const Divider(
          height: 10,
          color: Colors.transparent,
        ),
        RefreshIndicator(
          child: Column(
            children: [
              MyCard(
                title: 'Básico mensual',
                subtitle: 'Beneficios',
                subitems: const [
                  'Presencia dentro de la app',
                  'Espacios rotativos de publicidad',
                  'Reseñas y/o comentarios',
                  'Soporte técnico',
                ],
                precio: '80.00 MXN',
                buttonText: plan == 'basicomen' ? 'Cancelar' : 'Suscribirme',
                onPressed: () {
                  if (plan == 'basicomen') {
                    _showDialogCancel(
                        context,
                        '¿Estás seguro de terminar tu plan básico mensual?',
                        tokenUser);
                    return;
                  }
                  if (card) {
                    print('Tienes una tarjeta registrada');
                    _showDialogSuscribirse(
                        context,
                        '¿Quieres suscribirte al plan básico mensual?',
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
                color: Colors.white70,
              ),
              MyCard(
                title: 'Básico anual',
                subtitle: 'Beneficios',
                subitems: const [
                  'Presencia dentro de la app',
                  'Espacios rotativos de publicidad',
                  'Reseñas y/o comentarios',
                  'Soporte técnico',
                  'Descuento del 10% en comparación al plan mensual',
                ],
                precio: '864.00 MXN',
                buttonText: plan == 'basicoanual' ? 'Cancelar' : 'Suscribirme',
                onPressed: () {
                  if (plan == 'basicoanual') {
                    _showDialogCancel(
                        context,
                        '¿Estás seguro de terminar tu plan básico anual?',
                        tokenUser);
                    return;
                  }
                  if (card) {
                    print('Tienes una tarjeta registrada');
                    _showDialogSuscribirse(
                        context,
                        '¿Quieres suscribirte al plan básico anual?',
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
                color: Colors.yellow.shade200,
              ),
              MyCard(
                title: 'Premium mensual',
                subtitle: 'Beneficios',
                subitems: const [
                  'Mayor presencia dentro de la app',
                  'Espacios exclusivos de publicidad',
                  'Reseñas y/o comentarios',
                  "galería de fotos",
                  'Soporte técnico',
                ],
                precio: '150.00 MX',
                buttonText: plan == 'premiummen' ? 'Cancelar' : 'Suscribirme',
                onPressed: () {
                  if (plan == 'premiummen') {
                    _showDialogCancel(
                        context,
                        '¿Estás seguro de terminar tu plan premium mensual?',
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
                color: Colors.orange.shade200,
              ),
              MyCard(
                  title: 'Premium anual',
                  subtitle: 'Beneficios',
                  subitems: const [
                    'Mayor presencia dentro de la app',
                    'Espacios exclusivos de publicidad',
                    'Reseñas y/o comentarios',
                    'Soporte técnico',
                    "Galería de fotos",
                    'Descuento del 15% en comparación al plan premium mensual',
                  ],
                  precio: '1,530.00 MXN',
                  buttonText:
                      plan == 'premiumanual' ? 'Cancelar' : 'Suscribirme',
                  onPressed: () {
                    if (plan == 'premiumanual') {
                      _showDialogCancel(
                          context,
                          '¿Estás seguro de terminar tu plan premium anual?',
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
                  buttonColor:
                      plan == 'premiumanual' ? Colors.red : Colors.black,
                  buttonTextColor: Colors.white,
                  color: Colors.orange.shade300),
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
  final String precio;
  final String buttonText;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color color;

  const MyCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.subitems,
    required this.precio,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    const double titleFontSize = 22.0;
    const double subtitleFontSize = 15.0;
    const double subitemsFontSize = 16.0;

    return Card(
      margin: const EdgeInsets.all(25.0),
      color: color,
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
                fontWeight: FontWeight.bold,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subitems
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(children: [
                          Icon(
                            Icons.check,
                            color: Colors.blue[800],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: subitemsFontSize,
                              height: 1.2,
                            ),
                          ))
                        ]),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Precio: ',
                  style: TextStyle(
                      fontSize: subtitleFontSize, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Text(
                  precio,
                  style: const TextStyle(
                      fontSize: subtitleFontSize, fontWeight: FontWeight.bold),
                )
              ],
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
