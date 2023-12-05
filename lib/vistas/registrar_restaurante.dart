import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:PerfectConnection/controladores/restaurant_controller.dart';
import 'package:PerfectConnection/modelos/restaurant_model.dart';
import 'package:PerfectConnection/vistas/registrando_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class RegistrarRestaurante extends StatefulWidget {
  final int id;
  final Function updateState;
  const RegistrarRestaurante(
      {super.key, required this.id, required this.updateState});
  @override
  _RegistrarRestauranteState createState() => _RegistrarRestauranteState();
}

class _RegistrarRestauranteState extends State<RegistrarRestaurante> {
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  String seleccionActual = '';
  late Future<RestaurantModelo> _restaurantFuture;

  Uint8List? _imageData;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _imageData = Uint8List.fromList(imageBytes);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _restaurantFuture = _getRestaurantData();
  }

  Future<RestaurantModelo> _getRestaurantData() async {
    Box box = Hive.box('tokenBox');
    String tokenUser = box.get('token');
    return getRestaurant(tokenUser, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('tokenBox');
    String tokenUser = box.get('token');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF854),
        title: const Text(
          'Información básica',
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
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.home_work),
          ),
        ],
      ),
      body: RefreshIndicator(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: FutureBuilder<RestaurantModelo>(
                  //OJO AQUI CONSULTAR AL RESTAURANT CON CIERTA ID
                  future: _restaurantFuture,
                  builder: (context, AsyncSnapshot<RestaurantModelo> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.statusCode == 403) {
                        return Text(
                          snapshot.data!.message!,
                          style: const TextStyle(fontSize: 18),
                        );
                      }
                      return fomulario(snapshot.data!, tokenUser);
                    } else {
                      return cargandoMessage(context);
                    }
                  }),
            ),
          ),
          onRefresh: () {
            return Future(() {
              setState(() {
                _imageData = null;
                _nombreController.text = "";
                _telefonoController.text = "";
                _descripcionController.text = "";
              });
            });
          }),
    );
  }

  Widget fomulario(RestaurantModelo data, String tokenUser) {
    Uint8List _decodeImageString(String imageString) {
      // Decodificar la cadena base64 a Uint8List
      return Uint8List.fromList(base64.decode(imageString));
    }

    List<String> elementos = [
      '',
      'Taquería',
      'Pizzeria',
      'Puesto de Tamales',
      'Antojitos Mexicanos',
      'Lonchería',
      'Pulquería',
      'Marisquería',
      'Cantina',
      'Pozolería',
      'Café de Especialidad',
      'Tortería',
      'Churrería',
      'Tostadería',
      'Barbacoa y Consomé',
      'Cocina Yucateca',
      'Parrillada',
      'Panadería',
      'Restaurante de Comida Oaxaqueña',
      'Paletería',
      'Sushi Mexicano',
      'Tacos de Canasta'
    ];
    _imageData = data.logo != null && _imageData == null
        ? _decodeImageString(data.logo!)
        : _imageData;
    _nombreController.text =
        data.restaurant != null && _nombreController.text == ""
            ? data.restaurant!
            : _nombreController.text;
    _telefonoController.text =
        data.telefono != null && _telefonoController.text == ""
            ? data.telefono!.toString()
            : _telefonoController.text;
    seleccionActual = data.tipo != null && seleccionActual == ""
        ? data.tipo!
        : seleccionActual;
    _descripcionController.text =
        data.descripcion != null && _descripcionController.text == ""
            ? data.descripcion!
            : _descripcionController.text;

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Form(
        key: _formfield,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Logo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 15),
              Stack(
                alignment: Alignment.center,
                children: [
                  _imageData != null
                      ? SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Image.memory(_imageData!, fit: BoxFit.cover),
                        )
                      : Container(),
                  Positioned(
                    child: IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: () {
                        _getImage();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nombreController,
                maxLength: 50,
                decoration:
                    const InputDecoration(labelText: 'Nombre del restaurante'),
                validator: (value) {
                  bool textValid = RegExp(r"^[A-Za-z0-9áéíóúÁÉÍÓÚñÑ\s¡!¿?.,]+$")
                      .hasMatch(value!);
                  if (!textValid && value != '') {
                    return "No debe ingresar caracteres especiales";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _telefonoController,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (value) {
                  bool textValid = RegExp(r"^[0-9]+$").hasMatch(value!);
                  if (!textValid && value != '') {
                    return "No debe ingresar caracteres especiales";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Tipo de negocio',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                value: seleccionActual,
                items: elementos.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Actualiza la variable directamente sin setState
                  seleccionActual = newValue!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: null,
                controller: _descripcionController,
                maxLength: 100,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  bool textValid =
                      RegExp(r"^[A-Za-z0-9áéíóúÁÉÍÓÚñÑ\s¡!¿?.:,-]+$")
                          .hasMatch(value!);
                  if (!textValid && value != '') {
                    return "No debe ingresar caracteres especiales";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formfield.currentState!.validate()) {
                    debugPrint("validado correctamente");
                    String base64Image =
                        _imageData != null ? base64Encode(_imageData!) : '';
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrandoRestaurant(
                              tokenUser: tokenUser,
                              info: RestaurantModelo(
                                  logo: base64Image,
                                  restaurant: _nombreController.text,
                                  telefono: _telefonoController.text,
                                  tipo: seleccionActual,
                                  descripcion: _descripcionController.text),
                              id: widget.id,
                              updateState: widget.updateState),
                        ));
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF854)),
                child: const Text(
                  'Guardar cambios',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cargandoMessage(context) {
    return const Column(
      children: [
        SizedBox(height: 200),
        CircularProgressIndicator(
          color: Colors.amberAccent,
        ),
        SizedBox(height: 60),
      ],
    );
  }
}
