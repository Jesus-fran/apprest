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
      body: _terminosCondiciones(),
    );
  }
}

Widget _terminosCondiciones() {
  return const SingleChildScrollView(
    child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  '¿Qué es Perfect Connection?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'PerfectConection es una plataforma innovadora diseñada para potenciar y promover negocios locales, centrándose particularmente en el sector alimenticio (restaurantes, reto-bares, cocinas económicas, fondas, entre otros). Nuestra misión es brindar visibilidad a aquellos emprendedores que, debido a la falta de experiencia o recursos, encuentran desafiantes diseñar campañas publicitarias efectivas para sus establecimientos.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            )
          ],
        )),
  );
}
