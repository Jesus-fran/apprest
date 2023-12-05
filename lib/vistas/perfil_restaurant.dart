import 'dart:typed_data';

import 'dart:convert';
import 'package:baseapp/controladores/restaurant_controller.dart';
import 'package:baseapp/modelos/restaurant_model.dart';
import 'package:baseapp/vistas/mapa_restaurant.dart';
import 'package:baseapp/vistas/placeholders_home.dart';
import 'package:baseapp/vistas/proximamente.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class PerfilRestaurant extends StatefulWidget {
  final String name;
  final String portada;
  final int id;
  const PerfilRestaurant(
      {super.key, required this.name, required this.portada, required this.id});

  @override
  State<PerfilRestaurant> createState() => _PerfilRestaurantState();
}

class _PerfilRestaurantState extends State<PerfilRestaurant> {
  Uint8List decodeImageString(String imageString) {
    // Decodificar la cadena base64 a Uint8List
    return Uint8List.fromList(base64.decode(imageString));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              children: [
                Stack(
                  children: [
                    widget.portada != ""
                        ? Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: MemoryImage(
                                      decodeImageString(widget.portada)),
                                  fit: BoxFit.cover),
                            ),
                          )
                        : Container(
                            height: 200,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/imgnodisp.jpg"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                    Column(
                      children: [
                        AppBar(
                          title: Text(widget.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          backgroundColor: Colors.transparent,
                          elevation: 0, // Sin sombra
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              // Lógica para manejar el botón de retroceso
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                body(context),
              ],
            ),
            onRefresh: () {
              return Future(() {
                setState(() {});
              });
            }));
  }

  Widget body(BuildContext context) {
    var box = Hive.box('tokenBox');
    String tokenUser = box.get('token');
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Información basica',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          FutureBuilder<RestaurantModelo>(
              future: getProfileRestaurant(tokenUser, widget.id),
              builder: (context, AsyncSnapshot<RestaurantModelo> snapshot) {
                if (snapshot.hasData) {
                  return content(snapshot.data!, context);
                } else {
                  return skeletonLoad();
                }
              }),
          const SizedBox(
            height: 20,
          ),
        ]));
  }

  Widget content(RestaurantModelo restaurants, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: Icon(Icons.phone, color: Colors.green.shade400),
          title: restaurants.telefono != null
              ? TextButton(
                  style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 241, 241, 241))),
                  onPressed: () {
                    String tel = restaurants.telefono!;
                    // ignore: no_leading_underscores_for_local_identifiers
                    Future<void> _launchUrl() async {
                      if (!await launchUrl(Uri.parse('tel:$tel'))) {
                        throw Exception('Could not launch $tel');
                      }
                    }

                    _launchUrl();
                  },
                  child: Text(restaurants.telefono!))
              : const Text('Ninguno'),
        ),
        const Divider(
          color: Colors.grey,
          height: 20,
        ),
        ListTile(
          leading: const Icon(Icons.maps_home_work, color: Colors.orange),
          title: Text(restaurants.tipo ?? 'Ninguno'),
        ),
        const Divider(
          color: Colors.grey,
          height: 20,
        ),
        ListTile(
          title: Text(restaurants.descripcion ?? 'Ninguna descripción'),
        ),
        const Divider(
          color: Colors.grey,
          height: 40,
        ),
        const Text(
          'Ubicación',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 15,
        ),
        restaurants.ubicacion != null
            ? Card(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/icon-google-map.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Nos encontramos en ${restaurants.ubicacion}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.location_on,
                            color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              )
            : const Text("Ninguno"),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'Ofertas y menú',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 15,
        ),
        restaurants.oferta != null
            ? SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.memory(decodeImageString(restaurants.oferta!),
                    fit: BoxFit.cover),
              )
            : Container(height: 0),
        ListTile(
          title: Text(restaurants.descOferta ?? 'Ningún menú'),
        ),
        const SizedBox(
          height: 15,
        ),
        Card(
          elevation: 2,
          margin: const EdgeInsets.all(10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Proximamente()),
              );
            },
            child: Container(
              width: double.maxFinite,
              height: 100,
              padding: const EdgeInsets.all(16),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.photo_library_rounded,
                      size: 35, color: Colors.deepPurple),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Galería de fotos",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          'Calificaciones y opiniones',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('4',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
              ],
            )
          ],
        ),
        const Divider(
          color: Colors.grey,
          height: 40,
        ),
        const ListTile(
          title: Text("Daniel Nal"),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                ],
              ),
              Text(
                  "Comida rica, pedimos enchiladas suizas, chiapanecas y tacos de arrachera, todo muy bien. Está justo frente a la plaza en donde puedes cenar escuchando la marimba.")
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 20,
        ),
        const ListTile(
          title: Text("Neftali Enoc"),
          subtitle: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                ],
              ),
              Text(
                  "Excelente restaurante en Ocosingo... felicidades por la deliciosa comida. Por motivos de trabajo visité la ciudad y el restaurante las Delicias nos proporcionó desayuno exquisito, probé el huevo en diferentes variedades: revuelto con jamón y a la mexicana, los chilaquiles con pollo o el desayuno estudiante. Las tortas de milanesa y piernas deliciosas así como la comida: área Vera, pollo frito, consomé de pollo. Muy buena atención y sazón.")
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () {}, child: const Text("Ver más")),
            TextButton(onPressed: () {}, child: const Text("Opinar"))
          ],
        ),
        const SizedBox(
          height: 70,
        )
      ],
    );
  }

  Widget skeletonLoad() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 16.0),
            TitlePlaceholder(width: double.infinity),
            TitlePlaceholder(width: double.infinity),
            TitlePlaceholder(width: double.infinity),
            SizedBox(height: 16.0),
            BannerPlaceholder(),
            TitlePlaceholder(width: double.infinity),
            SizedBox(height: 16.0),
            BannerPlaceholder(),
            TitlePlaceholder(width: double.infinity),
            SizedBox(height: 16.0),
          ],
        ));
  }

  void showFilter(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context2) => Dialog.fullscreen(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: <Widget>[
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context2);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            const Center(
              child: Text(
                'Filtra tu busqueda',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
