import 'package:flutter/material.dart';

class PoliticasPrivacidad extends StatefulWidget {
  const PoliticasPrivacidad({super.key});

  @override
  State<PoliticasPrivacidad> createState() => _PoliticasPrivacidadState();
}

class _PoliticasPrivacidadState extends State<PoliticasPrivacidad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF854),
        title: const Text(
          'Política de Privacidad',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.format_align_right_outlined),
          ),
        ],
      ),
      body: _politicaPrivacidad(),
    );
  }
}

Widget _politicaPrivacidad() {
  return const SingleChildScrollView(
    child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Política de Privacidad de Perfect Connection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Fecha de entrada en vigor: 28 de Octubre del 2023',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Esta Política de Privacidad describe cómo Perfect Connection recopila, utiliza y comparte información personal de los usuarios de la Aplicación. Al utilizar la Aplicación, usted acepta y consiente las prácticas descritas en esta Política de Privacidad.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  '1. Información que Recopilamos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Información de Registro: Cuando crea una cuenta en la Aplicación, recopilamos información personal, como su nombre, dirección de correo electrónico y contraseña.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Información de Perfil: Puede elegir proporcionar información adicional en su perfil, como una foto de perfil y detalles de contacto.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Contenido Generado por el Usuario: La Aplicación permite a los usuarios cargar y compartir contenido, como fotos, reseñas y comentarios.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  '2. Uso de la Información',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Utilizamos la información recopilada para proporcionar y mejorar la funcionalidad de la Aplicación, para personalizar su experiencia y para comunicarnos con usted.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Podemos utilizar su información para enviar notificaciones, actualizaciones y promociones relacionadas con la Aplicación.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  '3. Compartir Información',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Compartimos su información con restaurantes y usuarios de la Aplicación, de acuerdo con la funcionalidad de la misma, como compartir reseñas y comentarios.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'No compartimos su información personal con terceros no afiliados, excepto cuando sea necesario para proporcionar los servicios de la Aplicación o cuando estemos obligados por ley.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  '4. Seguridad',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Tomamos medidas razonables para proteger su información personal. Sin embargo, no podemos garantizar la seguridad de la información transmitida a través de Internet.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  '5. Sus Derechos y Opciones',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Puede acceder, modificar o eliminar su información personal en la configuración de su cuenta en la Aplicación.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  '6. Cambios en esta Política de Privacidad',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Nos reservamos el derecho de modificar esta Política de Privacidad en cualquier momento. Cualquier cambio se notificará en la Aplicación. El uso continuado de la Aplicación después de dichos cambios constituirá su aceptación de la nueva Política de Privacidad.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  '7. Póngase en Contacto con Nosotros',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Si tiene preguntas o preocupaciones sobre esta Política de Privacidad, puede ponerse en contacto con nosotros en perfectconnection@gmail.com.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        )),
  );
}
