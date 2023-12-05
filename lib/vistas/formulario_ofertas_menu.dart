import 'dart:convert';
import 'dart:typed_data';

import 'package:PerfectConnection/controladores/restaurant_controller.dart';
import 'package:PerfectConnection/modelos/restaurant_model.dart';
import 'package:PerfectConnection/vistas/registrando_menu.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class FormOfertasMenu extends StatefulWidget {
  final int id;
  const FormOfertasMenu({super.key, required this.id});
  @override
  State<FormOfertasMenu> createState() => _FormOfertasMenuState();
}

class _FormOfertasMenuState extends State<FormOfertasMenu> {
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _menu = TextEditingController();
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
          'Ofertas y Menu',
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
              _menu.text = "";
            });
          });
        });
  }

  Widget fomulario(
      RestaurantModelo data, String tokenUser, BuildContext context) {
    Uint8List decodeImageString(String imageString) {
      // Decodificar la cadena base64 a Uint8List
      return Uint8List.fromList(base64.decode(imageString));
    }

    _imageData = data.oferta != null && _imageData == null
        ? decodeImageString(data.oferta!)
        : _imageData;
    _menu.text = data.descOferta != null && _menu.text == "" ? data.descOferta! : _menu.text;

    return ListView(
      children: [
        const Text(
          'Imagen de oferta',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 15),
        Builder(builder: (BuildContext contextImg) {
          return _buildImageStack(contextImg);
        }),
        const SizedBox(height: 20),
        const Text(
          'Menu del dia',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        Form(
          key: _formfield,
          child: TextFormField(
            controller: _menu,
            maxLines: 6,
            maxLength: 500,
            style: const TextStyle(
                fontSize: 16.0), // Ajustar el tamaño de la fuente
            decoration: const InputDecoration(
              hintText: 'Escribe aquí...',
              filled: true,
              border: InputBorder.none, // Eliminar el borde del InputDecoration
            ),
            validator: (value) {
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
              String base64Image =
                  _imageData != null ? base64Encode(_imageData!) : '';
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrandoMenu(
                            id: widget.id,
                            tokenUser: tokenUser,
                            info: RestaurantModelo(
                                oferta: base64Image, descOferta: _menu.text),
                          )));
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFF854)),
          child: const Text(
            'Guardar cambios',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const SizedBox(height: 10),
        const SizedBox(height: 30),
        const SizedBox(height: 5),
        const SizedBox(height: 10),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildImageStack(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _imageData != null
            ? SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.memory(_imageData!, fit: BoxFit.cover),
              )
            : Container(height: 200),
        Positioned(
          child: IconButton(
            iconSize: 70,
            icon: const Icon(Icons.add_box_rounded, color: Colors.grey),
            onPressed: () {
              _getImage();
            },
          ),
        ),
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
