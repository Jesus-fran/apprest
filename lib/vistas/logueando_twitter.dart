import 'package:baseapp/vistas/home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:twitter_login/twitter_login.dart';

class LogueandoTwitter extends StatefulWidget {
  const LogueandoTwitter({super.key});

  @override
  State<LogueandoTwitter> createState() => _LogueandoTwitterState();
}

class _LogueandoTwitterState extends State<LogueandoTwitter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: FutureBuilder(
              future: login(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data) {
                    // con WidgetsBinding.instance.addPostFrameCallback() evitamos que ocurra un error
                    // al intentar redirigir a una interfaz desde el builder, aseguramos que eso ocurra
                    // hasta que se haya construido todo.
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                        (route) => false,
                      );
                    });
                    return Container();
                  } else {
                    return errorMessage(context);
                  }
                }
                return cargandoMessage(context);
              }),
        ),
      ),
    );
  }
}

Future login() async {
  const String apiKey = '7e4RCvlyuPgZvfVeDtiTqn8Qr';
  const String apiSecretKey =
      'qsSKShrywBU2Dwp7lNEMgpYvqFdzcaBYIdPFPk79NfmGRX5r1S';

  final twitterLogin = TwitterLogin(
    /// Consumer API keys
    apiKey: apiKey,

    /// Consumer API Secret keys
    apiSecretKey: apiSecretKey,

    redirectURI: 'flutter-twitter-login://',
  );

  final authResult = await twitterLogin.login();
  switch (authResult.status) {
    case TwitterLoginStatus.loggedIn:
      // success
      debugPrint('====== Login success ======');
      var box = Hive.box('tokenBox');
      box.put('username', authResult.user!.name);
      return true;
    case TwitterLoginStatus.cancelledByUser:
      // cancel
      debugPrint('====== Login cancel ======');
      return false;
    case TwitterLoginStatus.error:
    case null:
      // error
      debugPrint('====== Login error ======');
      return false;
  }
}

Widget cargandoMessage(context) {
  return const Column(
    children: [
      SizedBox(height: 200),
      Text(
        'Iniciando sesión con Twitter..',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 60),
      LinearProgressIndicator(
        color: Colors.amberAccent,
      ),
      SizedBox(height: 60),
      Text(
        'Espere un momento, por favor.',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget errorMessage(context) {
  return Column(
    children: [
      const SizedBox(height: 150),
      const Text('Algo ocurrió..', style: TextStyle(fontSize: 30)),
      const SizedBox(height: 60),
      const Icon(
        Icons.error,
        size: 50,
        color: Colors.redAccent,
      ),
      const SizedBox(height: 60),
      const Text(
        'Hubo un error al iniciar sesión con tu cuenta de Twitter',
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 50),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 255, 156, 98)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: const Text(
          "Intentar de nuevo",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
