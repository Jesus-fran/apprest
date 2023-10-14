import 'package:flutter/material.dart';

class LoginInputPage extends StatelessWidget {
  const LoginInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                icon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            ElevatedButton(
              child: const Text('Entrar'),
              onPressed: () {
                // Aquí agregarías la lógica para manejar el inicio de sesión.
              },
            ),
          ],
        ),
      ),
    );
  }
}
