import 'package:flutter/material.dart';

class Planes extends StatelessWidget {
  const Planes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 215, 214, 214), // Ca
      body: Container(
        margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '¡Bienvenido! a la sección de crear Restaurante. Para continuar elija el tipo de plan que desea adquirir.',
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(
              height: 50,
              color: Colors.transparent,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 25.0), // para el margen izquiero
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
                    title: 'Premium',
                    subtitle: 'Beneficios',
                    subitems: [
                      'Listado en la plataforma',
                      'Espacios rotativos de publicidad',
                      'Soporte por correo'
                    ],
                    buttonText: 'Botón',
                    onPressed: () {
                      // Lógica para el botón
                    },
                    buttonColor: Colors.black,
                    buttonTextColor: Colors.white,
                  ),
                  MyCard(
                    title: 'Premium Anual',
                    subtitle: 'Beneficios',
                    subitems: ['xd', 'xd', 'xd'],
                    buttonText: 'Botón',
                    onPressed: () {
                      // Lógica para el botón
                    },
                    buttonColor: Colors.black,
                    buttonTextColor: Colors.white,
                  ),
                  MyCard(
                    title: 'Premium Pro',
                    subtitle: 'Beneficios',
                    subitems: ['xd', 'xd', 'xd'],
                    buttonText: 'Botón',
                    onPressed: () {
                      // Lógica para el botón
                    },
                    buttonColor: Colors.black,
                    buttonTextColor: Colors.white,
                  ),
                  MyCard(
                    title: 'Premium Pro Anual',
                    subtitle: 'Subtitulo 3',
                    subitems: ['xd', 'xd', 'xd'],
                    buttonText: 'Botón',
                    onPressed: () {
                      // Lógica para el botón
                    },
                    buttonColor: Colors.black,
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
        ),
      ),
    );
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

  MyCard({
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
    final double titleFontSize = 22.0;
    final double subtitleFontSize = 15.0;
    final double subitemsFontSize = 12.0;

    return Card(
      margin: EdgeInsets.all(25.0),
      color: Color.fromARGB(255, 255, 252, 161),
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
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: subtitleFontSize,
                height: 1.0,
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subitems
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '• $item',
                          style: TextStyle(
                            fontSize: subitemsFontSize,
                            height: 1.2,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonText),
                style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  onPrimary: buttonTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
