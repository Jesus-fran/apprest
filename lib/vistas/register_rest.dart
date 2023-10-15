import 'package:flutter/material.dart';

class RegisterRest extends StatefulWidget {
  const RegisterRest({super.key});

  @override
  RegisterRestState createState() => RegisterRestState();
}

class RegisterRestState extends State<RegisterRest> {
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  bool passwordHidden = true;
  bool repeatPasswordHidden = true;

  void _register() {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    debugPrint("Nombre: $name");
    debugPrint("Correo: $email");
    debugPrint("Contraseña: $password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF626B),
        title: const Text(
          'Crear cuenta',
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
            child: Image.asset('assets/restaurante.png', width: 40),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                const Text('Nombre',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.asset('assets/usuario2.png',
                          width: 20, height: 20),
                    ),
                    hintText: "Nombre",
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    bool nameValid =
                        RegExp(r"^[A-Za-záéíóúÁÉÍÓÚñÑ\s]+$").hasMatch(value!);
                    if (value.isEmpty) {
                      return "Ingrese un nombre";
                    } else if (!nameValid) {
                      return "Su nombre no debe tener caracteres especiales";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
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
                    hintText: "Correo electrónico",
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    bool nameValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
                const SizedBox(height: 20),
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
                            r"^(?=.*[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ])(?=.*\d)(?=.*[@$!%*?&])[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ\d@$!%*?&]+$")
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
                const SizedBox(height: 20),
                const Text('Repetir contraseña',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4.0),
                TextFormField(
                  controller: _repeatPasswordController,
                  obscureText: repeatPasswordHidden,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Image.asset('assets/password.png',
                          width: 20, height: 20),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          repeatPasswordHidden = !repeatPasswordHidden;
                        });
                      },
                      child: Icon(repeatPasswordHidden
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                    hintText: "Repetir contraseña",
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ingrese una contraseña";
                    } else if (value != _passwordController.text) {
                      return "Las contraseñas deben coincidir";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 30),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(height: 50, width: 500),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formfield.currentState!.validate()) {
                        debugPrint("datos login agregado correctamente");
                        _register();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFFF626B)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
