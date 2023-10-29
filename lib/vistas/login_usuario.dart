import 'package:baseapp/modelos/usuario_model.dart';
import 'package:baseapp/vistas/logueando_usuario.dart';
import 'package:baseapp/vistas/politicas_privacidad.dart';
import 'package:baseapp/vistas/terminos_condiciones.dart';
import 'package:flutter/material.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State<LoginUser> {
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordHidden = true;
  bool _terminos = false;

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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Checkbox(
                      isError: true,
                      value: _terminos,
                      onChanged: (bool? newVal) {
                        setState(() {
                          _terminos = newVal!;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.transparent;
                        }
                        return Colors.transparent;
                      }),
                      checkColor: Colors.black,
                    ),
                    const Text(
                      'Acepto los',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TerminosCondiciones()),
                              );
                            },
                            child: const Text(
                              'Términos y condiciones',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ))),
                    const Text(
                      'y las',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PoliticasPrivacidad()),
                              );
                            },
                            child: const Text(
                              'Políticas de Privacidad',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ))),
                  ],
                ),
                const SizedBox(height: 50),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(height: 50, width: 500),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formfield.currentState!.validate()) {
                        if (_terminos) {
                          debugPrint("Validado correctamente");
                          _login();
                        } else {
                          debugPrint('Error!!');
                          SnackBar snack_1 = const SnackBar(
                            content: Text(
                              "Acepte los términos y condiciones.",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 16),
                            ),
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack_1);
                        }
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
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TerminosCondiciones()),
                      );
                    },
                    child: const Text(
                      '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
