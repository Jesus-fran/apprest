import 'package:flutter/material.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
        backgroundColor: Color(0xFFFFF854),
        title: Text(
          'Crear cuenta',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(6),
                  child:
                      Image.asset('assets/usuario2.png', width: 20, height: 20),
                ),
                hintText: "Nombre",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            Text('Correo', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4.0),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(6),
                  child:
                      Image.asset('assets/correo.png', width: 20, height: 20),
                ),
                hintText: "Correo",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            Text('Contraseña', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(6),
                  child:
                      Image.asset('assets/password.png', width: 20, height: 20),
                ),
                hintText: "Contraseña",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: 50, width: 500),
              child: ElevatedButton(
                onPressed: _register,
                child: Text(
                  "Continuar",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFFFFF854)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.grey,
                    height: 1,
                    margin: EdgeInsets.only(right: 5),
                  ),
                ),
                Text("O"),
                Expanded(
                  child: Container(
                    color: Colors.grey,
                    height: 1,
                    margin: EdgeInsets.only(left: 5),
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
