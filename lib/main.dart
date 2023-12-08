import 'package:PerfectConnection/controladores/check_internet.dart';
import 'package:PerfectConnection/vistas/home_pages.dart';
import 'package:PerfectConnection/vistas/registrar_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:gdpr_dialog/gdpr_dialog.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'vistas/login_usuario.dart'; // Importamos la vista

final internetChecker = CheckInternetConnection();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directoryCache = await getApplicationCacheDirectory();
  Hive.init(directoryCache.path);
  final tokenBox = await Hive.openBox('tokenBox');
  Stripe.publishableKey =
      'pk_test_51K4UY3AIicvw06NvdfFa6l4FL5DG1ZtXbRyqBcsy43Sd4XHdgjrShVBpWsOmE3uYXyFAdiiIwZnUSbognXEPRO9X00STeriSTo';
  await Stripe.instance.applySettings();
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
        title: 'Perfect Connection',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.grey,
        ),
        home:
            const LoginPage(), //Cambiar esta función para probar nuevas interfaces
        debugShowCheckedModeBanner: false,
      );
    }

    //Si exite un token registrado, quiere decir que se ha iniciado sesión, entonces redirige
    //a la pantalla de Home
    return MaterialApp(
      title: 'Perfect Connection',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.grey,
      ),
      home: HomePages(),
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
  void initState() {
    GdprDialog.instance.showDialog(
        isForTest: true, testDeviceId: '63BFF6BBDA6E9DD23473C4AF6E836A6D');
    super.initState();
  }

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
