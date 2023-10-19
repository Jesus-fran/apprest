import 'package:baseapp/modelos/user_model.dart';
import 'package:baseapp/vistas/logueando_twitter.dart';
import 'package:baseapp/vistas/logueando.dart';
import 'package:flutter/material.dart';
import 'package:twitter_login/twitter_login.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State<LoginUser> {
  final String apiKey = '7e4RCvlyuPgZvfVeDtiTqn8Qr';
  final String apiSecretKey =
      'qsSKShrywBU2Dwp7lNEMgpYvqFdzcaBYIdPFPk79NfmGRX5r1S';

  final _formfield = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordHidden = true;

  void _login() {
    final email = _emailController.text;
    final password = _passwordController.text;

    final UserModelo usuario =
        UserModelo(email: email, password: password, username: '');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Logueando(
                  usuario: usuario,
                )));
    debugPrint("Correo: $email");
    debugPrint("Contraseña: $password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF854),
        title: const Text(
          'Iniciar sesión',
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/usuario.png', width: 40),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formfield,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Text('Correo',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4.0),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.asset('assets/correo.png',
                          width: 20, height: 20),
                    ),
                    hintText: "Correo",
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    bool nameValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~ñÑáéíóúÁÉÍÓÚ]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value.isEmpty) {
                      return "Ingrese un correo electrónico";
                    } else if (!nameValid) {
                      return "Su correo no es valido";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 40),
                const Text('Contraseña',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: passwordHidden,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.asset('assets/password.png',
                          width: 20, height: 20),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passwordHidden = !passwordHidden;
                        });
                      },
                      child: Icon(passwordHidden
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    hintText: "Contraseña",
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    bool passInvalid = RegExp(
                            r"^(?=.*[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ])(?=.*\d)(?=.*[@$!%*?&^#/_.;\s:-])[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ\d@$!%*?&^#/_.;\s:-]+$")
                        .hasMatch(value!);
                    if (value.isEmpty) {
                      return "Ingrese una contraseña";
                    } else if (!passInvalid) {
                      return "Al menos una minúscula o mayúscula, un número y un caracter.";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 50),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(height: 50, width: 500),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formfield.currentState!.validate()) {
                        debugPrint("Validado correctamente");
                        _login();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFFF854)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Continuar",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        height: 1,
                        margin: const EdgeInsets.only(right: 5),
                      ),
                    ),
                    const Text("O"),
                    Expanded(
                      child: Container(
                        color: Colors.grey,
                        height: 1,
                        margin: const EdgeInsets.only(left: 5),
                      ),
                    ),
                  ],
                ),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(height: 50, width: 500),
                  child: ElevatedButton(
                    onPressed: () {
                      //loginV2(apiKey, apiSecretKey);
                      login(context, apiKey, apiSecretKey);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 87, 123, 190)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Twitter',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Use Twitter API v1.1
Future login(context, apiKey, apiSecretKey) async {
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LogueandoTwitter(
                    username: authResult.user!.name,
                    status: true,
                  )));
      break;
    case TwitterLoginStatus.cancelledByUser:
      // cancel
      debugPrint('====== Login cancel ======');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LogueandoTwitter(
                    username: '',
                    status: false,
                  )));
      break;
    case TwitterLoginStatus.error:
    case null:
      // error
      debugPrint('====== Login error ======');
      MaterialPageRoute(
          builder: (context) => const LogueandoTwitter(
                username: '',
                status: false,
              ));
      break;
  }
}
