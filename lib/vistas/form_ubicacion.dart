import 'dart:typed_data';

import 'package:PerfectConnection/controladores/restaurant_controller.dart';
import 'package:PerfectConnection/modelos/restaurant_model.dart';
import 'package:PerfectConnection/vistas/mapa_restaurant.dart';
import 'package:PerfectConnection/vistas/registrando_menu.dart';
import 'package:PerfectConnection/vistas/registrando_ubicacion.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class FormUbicacion extends StatefulWidget {
  final int id;
  final String name;
  const FormUbicacion({super.key, required this.id, required this.name});
  @override
  State<FormUbicacion> createState() => _FormUbicacionState();
}

class _FormUbicacionState extends State<FormUbicacion> {
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _ubicacion = TextEditingController();
  Uint8List? _imageData;
  late Future<RestaurantModelo> _restaurantFuture;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF854),
        title: const Text(
          'Ubicación',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    Box box = Hive.box('tokenBox');
    String tokenUser = box.get('token');
    return RefreshIndicator(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: FutureBuilder<RestaurantModelo>(
              future: _restaurantFuture,
              builder: (context, AsyncSnapshot<RestaurantModelo> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.statusCode == 403) {
                    return Text(
                      snapshot.data!.message!,
                      style: const TextStyle(fontSize: 18),
                    );
                  }
                  return fomulario(snapshot.data!, tokenUser, context);
                } else {
                  return cargandoMessage(context);
                }
              }),
        ),
        onRefresh: () {
          return Future(() {
            setState(() {
              _restaurantFuture = _getRestaurantData();
              _imageData = null;
              _ubicacion.text = "";
            });
          });
        });
  }

  Widget fomulario(
      RestaurantModelo data, String tokenUser, BuildContext context) {
    _ubicacion.text = data.ubicacion != null && _ubicacion.text == ""
        ? data.ubicacion!
        : _ubicacion.text;

    return ListView(
      children: [
        const Text(
          'Describe la ubicación de tu negocio',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 20),
        Form(
          key: _formfield,
          child: TextFormField(
            maxLines: 3,
            controller: _ubicacion,
            maxLength: 100,
            style: const TextStyle(
                fontSize: 16.0), // Ajustar el tamaño de la fuente
            decoration: const InputDecoration(
              hintText: 'Escribe aquí...',
              filled: true,
              border: InputBorder.none, // Eliminar el borde del InputDecoration
            ),
            validator: (value) {
              if (value == "") {
                return "Ingrese su dirección";
              }
              if (value.toString().length < 4) {
                return "Ingrese al menos 4 caracteres";
              }
              bool textValid = RegExp(r"^[A-Za-z0-9áéíóúÁÉÍÓÚñÑ\s¡!¿?.:,-]+$")
                  .hasMatch(value!);
              if (!textValid && value != '') {
                return "No debe ingresar caracteres especiales";
              } else {
                return null;
              }
            },
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            if (_formfield.currentState!.validate()) {
              debugPrint("validado correctamente");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrandoUbicacion(
                            id: widget.id,
                            tokenUser: tokenUser,
                            info: RestaurantModelo(ubicacion: _ubicacion.text),
                          )));
            }
          },
          style: ElevatedButton.styleFrom(
              shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))),
              backgroundColor: const Color(0xFFFFF854)),
          child: const Text(
            'Guardar cambios',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const SizedBox(height: 30),
        Card(
          elevation: 2,
          margin: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MapaRestaurant(
                          name: widget.name,
                          id: widget.id,
                        )),
              );
            },
            hoverColor: Colors.green.shade900,
            child: Container(
              color: Colors.green.shade300,
              width: double.maxFinite,
              height: 100,
              padding: const EdgeInsets.all(16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.location_on_rounded,
                      size: 35, color: Colors.redAccent),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Visualizar",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        const SizedBox(height: 10),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget cargandoMessage(context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 200),
          CircularProgressIndicator(
            color: Colors.amberAccent,
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
