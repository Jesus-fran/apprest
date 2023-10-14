import 'package:flutter/material.dart';

class RegisterRest extends StatefulWidget {
  const RegisterRest({super.key});

  @override
  RegisterRestState createState() => RegisterRestState();
}

class RegisterRestState extends State<RegisterRest> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    print("Nombre: $name");
    print("Correo: $email");
    print("Contraseña: $password");
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(6),
                  child:
                      Image.asset('assets/usuario2.png', width: 20, height: 20),
                ),
                hintText: "Nombre",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            const Text('Correo', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(6),
                  child:
                      Image.asset('assets/correo.png', width: 20, height: 20),
                ),
                hintText: "Correo",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            const Text('Contraseña', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(6),
                  child:
                      Image.asset('assets/password.png', width: 20, height: 20),
                ),
                hintText: "Contraseña",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(height: 50, width: 500),
              child: ElevatedButton(
                onPressed: _register,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFFF626B)),
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
    );
  }
}
