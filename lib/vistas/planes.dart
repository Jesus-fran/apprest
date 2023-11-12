import 'package:flutter/material.dart';

class Planes extends StatelessWidget {
  const Planes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                title: 'Premium',
                subtitle: 'Beneficios',
                subitems: const [
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
                subitems: const ['xd', 'xd', 'xd'],
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
                subitems: const ['xd', 'xd', 'xd'],
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
                subitems: const ['xd', 'xd', 'xd'],
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
