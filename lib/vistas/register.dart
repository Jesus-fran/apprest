import 'package:flutter/material.dart';
import 'register_user.dart'; // Importas la página de registro de usuario
import 'register_rest.dart'; // Importas la página de registro de restaurante

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                      "¡Hola! Te damos la bienvenida a Perfect Connection. A continuación elige el tipo de registro que quieres realizar.",
                      style: TextStyle(fontSize: 13.5),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: cmToPx(0.8)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterUser(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFF854),
                                fixedSize: Size(cmToPx(2), cmToPx(2)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Image.asset(
                                "assets/usuario.png",
                                width: cmToPx(3.0),
                                height: cmToPx(3.0),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            const Text("Usuario")
                          ],
                        ),
                        SizedBox(width: cmToPx(0.2)),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterRest(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF626B),
                                fixedSize: Size(cmToPx(2), cmToPx(2)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Image.asset(
                                "assets/restaurante.png",
                                width: cmToPx(3.0),
                                height: cmToPx(3.0),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            const Text("Restaurante")
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
