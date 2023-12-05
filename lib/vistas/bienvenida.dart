import 'package:PerfectConnection/vistas/home_pages.dart';
import 'package:flutter/material.dart';

class Bienvenida extends StatefulWidget {
  const Bienvenida({super.key});

  @override
  State<Bienvenida> createState() => _BienvenidaState();
}

class _BienvenidaState extends State<Bienvenida> {
  @override
  Widget build(BuildContext context) {
    // Convertir cm a pixels, asumiendo una resolución de 150 ppi (aproximado)
    double cmToPx(double cm) => cm * 59.0551;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/fondo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: BiteClipper(),
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.55,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, -MediaQuery.of(context).size.height * 0.30),
                child: Image.asset(
                  "assets/logo.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              left: cmToPx(0.4),
              right: cmToPx(0.4),
              bottom: cmToPx(0.3),
              top: MediaQuery.of(context).size.height * 0.5 -
                  cmToPx(0.8) -
                  cmToPx(0.5),
              child: Container(
                padding: EdgeInsets.all(cmToPx(0.5)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Bienvenido",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "¡Hola! Te damos la bienvenida a Perfect Connection. A continuación puedes navegar y buscar lo  que te interesa.",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: cmToPx(0.8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: cmToPx(0.2)),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePages()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF626B),
                                fixedSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.restaurant),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Explorar',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BiteClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0.0, size.height * 0.1);
    path.quadraticBezierTo(
        size.width / 2, size.height * 0.30, size.width, size.height * 0.1);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
