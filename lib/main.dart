import 'package:baseapp/vistas/home.dart';
import 'package:baseapp/vistas/registrar_usuario.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'vistas/login_usuario.dart'; // Importamos la vista

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directoryCache = await getApplicationCacheDirectory();
  Hive.init(directoryCache.path);
  final tokenBox = await Hive.openBox('tokenBox');
  runApp(MyApp(
    tokenBox: tokenBox,
  ));
}

class MyApp extends StatelessWidget {
  final Box tokenBox;
  const MyApp({super.key, required this.tokenBox});

  @override
  Widget build(BuildContext context) {
    //Si no existe un token, quiere decir que no se ha iniciado sesión.
    if (tokenBox.get('token') == null || tokenBox.get('') == '') {
      return MaterialApp(
        title: 'Mi aplicación',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const LoginPage(), //Cambiar esta función para probar nuevas interfaces
        debugShowCheckedModeBanner: false,
      );
    }

    //Si exite un token registrado, quiere decir que se ha iniciado sesión, entonces redirige
    //a la pantalla de Home
    return MaterialApp(
      title: 'Mi aplicación',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const Home(),
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
                            builder: (context) => const LoginUser()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFFFF854),
                      side:
                          const BorderSide(color: Color(0xFFFFF854), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: const Text('Iniciar sesión',
                        style: TextStyle(fontSize: 24)),
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
                        MaterialPageRoute(
                            builder: (context) => const RegistrarUsuario()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFFF626B),
                      side:
                          const BorderSide(color: Color(0xFFFF626B), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: const Text('Registrarse',
                        style: TextStyle(fontSize: 24)),
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

//Prueba