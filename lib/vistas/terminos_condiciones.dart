import 'package:baseapp/vistas/politicas_privacidad.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TerminosCondiciones extends StatefulWidget {
  const TerminosCondiciones({super.key});

  @override
  State<TerminosCondiciones> createState() => _TerminosCondicionesState();
}

class _TerminosCondicionesState extends State<TerminosCondiciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF854),
        title: const Text(
          'Términos y condiciones',
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
      body: _terminosCondiciones(context),
    );
  }
}

Widget _terminosCondiciones(context) {
  return SingleChildScrollView(
    child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  '¿Qué es Perfect Connection?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'PerfectConection es una plataforma innovadora diseñada para potenciar y promover negocios, centrándose particularmente en el sector alimenticio (restaurantes, reto-bares, cocinas económicas, fondas, entre otros).',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Términos y Condiciones de Uso de Perfect Connection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Fecha de entrada en vigor: 28 de Octubre del 2023',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Por favor, lea detenidamente estos términos y condiciones de uso ("Términos y Condiciones") antes de utilizar la aplicación Perfect Connection.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '1. Aceptación de los Términos y Condiciones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Al utilizar la Aplicación, usted acepta y se compromete a cumplir estos Términos y Condiciones. Si no está de acuerdo con estos Términos y Condiciones, no utilice la Aplicación.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  '2. Registro',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Para acceder y utilizar ciertas funciones de la Aplicación, es posible que deba registrarse y crear una cuenta. Usted se compromete a proporcionar información precisa y actualizada durante el proceso de registro y a mantener sus datos de contacto actualizados.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Usted es responsable de mantener la confidencialidad de su nombre de usuario y contraseña y acepta no compartir esta información con terceros. Usted será el único responsable de todas las actividades que ocurran en su cuenta.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  '3. Política de Privacidad',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                text:
                    'El uso de la Aplicación está sujeto a nuestra ',
                style: const TextStyle(color: Colors.black, fontSize: 18),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Política de Privacidad.',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PoliticasPrivacidad()),
                        );
                      },
                  ),
                  const TextSpan(
                      text:
                          ' Al utilizar la Aplicación, usted acepta las prácticas de privacidad descritas en la Política de Privacidad.'),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  '4. Contenido de la Aplicación',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'La Aplicación permite a los restaurantes y usuarios cargar y compartir contenido, como fotos, reseñas y comentarios. Usted es el único responsable del contenido que carga y comparte en la Aplicación.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Usted se compromete a no cargar ni compartir contenido que sea difamatorio, obsceno, ilegal o que viole los derechos de terceros, incluyendo derechos de propiedad intelectual.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  '5. Responsabilidad y Exención de Garantía',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'La Aplicación se proporciona "tal cual" y "según disponibilidad", sin garantías de ningún tipo. No garantizamos que la Aplicación sea ininterrumpida, segura o libre de errores.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'No somos responsables de los actos u omisiones de los usuarios de la Aplicación. Usted utiliza la Aplicación bajo su propio riesgo.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  '6. Ley Aplicable y Jurisdicción',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Estos Términos y Condiciones se regirán e interpretarán de conformidad con las leyes de los Estados Unidos Mexicanos y cualquier disputa que surja o esté relacionada con estos Términos y Condiciones estará sujeta a la jurisdicción de los tribunales del estado de Chiapas, México.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  '7. Cambios en los Términos y Condiciones',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Nos reservamos el derecho de modificar estos Términos y Condiciones en cualquier momento. Cualquier cambio se notificará en la Aplicación. El uso continuo de la Aplicación después de dichos cambios constituirá su aceptación de los nuevos Términos y Condiciones.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        )),
  );
}
