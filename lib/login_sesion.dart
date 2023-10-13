import 'package:flutter/material.dart';

class LoginInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                icon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
                icon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            ElevatedButton(
              child: Text('Entrar'),
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
