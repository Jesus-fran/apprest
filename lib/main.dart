import 'package:flutter/material.dart';
import 'login_sesion.dart'; // Importamos la vista
import 'register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.9;
    double offset = MediaQuery.of(context).size.height * 0.2;

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
            // logotipo
            Transform.translate(
              offset: Offset(0, -offset),
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  heightFactor: 0.6,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset("assets/logo.png", fit: BoxFit.contain),
                  ),
                ),
              ),
            ),
            // Botón "Iniciar sesión"
            Positioned(
              left: 0,
              right: 0,
              bottom: 3 * 28.35 + 80,
              child: Center(
                child: SizedBox(
                  width: width,
                  child: OutlinedButton(
                    onPressed: () {
                      // vista de inicio de sesión
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginInputPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Color(0xFFFFF854),
                      side: BorderSide(color: Color(0xFFFFF854), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ),
                    child:
                        Text('Iniciar sesión', style: TextStyle(fontSize: 24)),
                  ),
                ),
              ),
            ),
            // Botón "Registrarse"
            Positioned(
              left: 0,
              right: 0,
              bottom: 3 * 28.35,
              child: Center(
                child: SizedBox(
                  width: width,
                  child: OutlinedButton(
                    onPressed: () {
                      // ir a vista de registro
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      backgroundColor: Color(0xFFFF626B),
                      side: BorderSide(color: Color(0xFFFF626B), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Text('Registrarse', style: TextStyle(fontSize: 24)),
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
