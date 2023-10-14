import 'package:flutter/material.dart';
import 'vistas/login_sesion.dart'; // Importamos la vista
import 'vistas/register.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.9;
    double offset = MediaQuery.of(context).size.height * 0.2;

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
                            builder: (context) => const LoginInputPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFFFF854),
                      side: const BorderSide(color: Color(0xFFFFF854), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child:
                        const Text('Iniciar sesión', style: TextStyle(fontSize: 24)),
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
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFFF626B),
                      side: const BorderSide(color: Color(0xFFFF626B), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: const Text('Registrarse', style: TextStyle(fontSize: 24)),
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
