import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // esto es oara definir el tamaño de la pantalla
    double cmToPx(double cm) => cm * 59.0551;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              left: cmToPx(0.5),
              right: cmToPx(0.5),
              bottom: cmToPx(0.5),
              top: MediaQuery.of(context).size.height * 0.5 +
                  MediaQuery.of(context).size.height * 0.15 +
                  150 -
                  cmToPx(5) -
                  cmToPx(0.5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Bienvenido",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "¡Hola! Te damos la bienvenida a Perfect Conection. A continuación elija el tipo de registro que quiere realizar.",
                        style: TextStyle(
                          height: 2.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
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
        size.width / 2, size.height * 0.50, size.width, size.height * 0.1);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
