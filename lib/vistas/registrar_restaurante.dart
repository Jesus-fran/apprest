import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegistrarRestaurante extends StatefulWidget {
  @override
  _RegistrarRestauranteState createState() => _RegistrarRestauranteState();
}

class _RegistrarRestauranteState extends State<RegistrarRestaurante> {
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _tipoCocinaController = TextEditingController();
  TextEditingController _horarioController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();

  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icono para elegir imagen
              IconButton(
                icon: Icon(Icons.image),
                onPressed: () {
                  _getImage();
                },
              ),
              SizedBox(height: 20),

              // Muestra la imagen seleccionada
              _image != null
                  ? Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(_image!),
                        ),
                      ),
                    )
                  : Container(),

              TextFormField(
                controller: _nombreController,
                decoration:
                    InputDecoration(labelText: 'Nombre del restaurante'),
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _direccionController,
                decoration: InputDecoration(labelText: 'Dirección'),
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _telefonoController,
                decoration: InputDecoration(labelText: 'Teléfono'),
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _tipoCocinaController,
                decoration: InputDecoration(labelText: 'Zona'),
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _horarioController,
                decoration: InputDecoration(labelText: 'Categoría o tipo'),
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  // Aquí puedes manejar la lógica para enviar los datos
                  // Puedes acceder a los valores con _nombreController.text, _direccionController.text, etc.
                },
                child: Text('Registrar Restaurante'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
