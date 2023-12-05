import 'dart:convert';
import 'dart:typed_data';

import 'package:PerfectConnection/controladores/restaurant_controller.dart';
import 'package:PerfectConnection/modelos/restaurant_model.dart';
import 'package:PerfectConnection/vistas/filter_restaurant.dart';
import 'package:PerfectConnection/vistas/perfil_restaurant.dart';
import 'package:PerfectConnection/vistas/placeholders_home.dart';
import 'package:PerfectConnection/vistas/search_restaurant.dart';
import 'package:PerfectConnection/vistas/warning_internet.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatelessWidget {
  final Function onstateUpdate;
  Home({Key? key, required this.onstateUpdate}) : super(key: key);
  final int _value = 1;
  final List<String> elementos = [
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

  String getSaludo() {
    var hora = DateTime.now().hour;
    var box = Hive.box('tokenBox');
    String username = box.get('username') ?? '';

    if (hora < 12) {
      return 'Buenos días, $username';
    } else if (hora < 18) {
      return 'Buenas tardes, $username';
    } else {
      return 'Buenas noches, $username';
    }
  }

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('tokenBox');
    String tokenUser = box.get('token');
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: RefreshIndicator(
        onRefresh: () {
          return Future(() {
            debugPrint("Actualiza pantalla");
            onstateUpdate();
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const WarningWidgetValueNotifier(),
              const SizedBox(
                height: 10,
              ),
              Text(
                getSaludo(),
                style: const TextStyle(
                  fontSize: 16, // Modifica el tamaño del saludo
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: '¿Que deseas comer?',
                                border: InputBorder.none,
                              ),
                              onSubmitted: (value) {
                                debugPrint(value);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchRestaurant(busqueda: value)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.tune,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        showFilter(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder<List<RestaurantModelo>>(
                  future: getAllRestaurants(tokenUser),
                  builder: (context,
                      AsyncSnapshot<List<RestaurantModelo>> snapshot) {
                    if (snapshot.hasData) {
                      return content(snapshot.data!, context);
                    } else {
                      return skeletonLoad();
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget content(List<RestaurantModelo> restaurants, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Categorías",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text("Ver más")),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cardCategory("Taquería", "assets/icon-taqueria.png", context),
            cardCategory("Pizzería", "assets/icon-pizzeria.png", context),
            cardCategory(
                "Hamburgesería", "assets/icon-hamburgueseria.png", context),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Restaurantes populares",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextButton(onPressed: () {}, child: const Text("Ver más"))
          ],
        ),
        Column(
          children: restaurants
              .map((item) => cardRestaurant(
                  context,
                  item.logo ?? '',
                  item.restaurant ?? '',
                  item.tipo ?? '',
                  item.id_restaurant ?? 0))
              .toList(),
        ),
      ],
    );
  }

  Widget cardRestaurant(
      BuildContext context, String logo, String name, String tipo, int id) {
    Uint8List decodeImageString(String imageString) {
      // Decodificar la cadena base64 a Uint8List
      return Uint8List.fromList(base64.decode(imageString));
    }

    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PerfilRestaurant(
                      name: name,
                      portada: logo,
                      id: id,
                    )),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: logo != ""
                  ? Image.memory(decodeImageString(logo), fit: BoxFit.cover)
                  : Image.asset(
                      'assets/imgnodisp.jpg',
                      fit: BoxFit.cover,
                    ),
            ),
            ListTile(
              title: Text(
                name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              trailing: tipo != ""
                  ? SizedBox(
                      width: 100,
                      child: Chip(
                          labelPadding: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(1),
                          label: Text(
                            tipo,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                    )
                  : const Text(""),
              subtitle: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                  Icon(Icons.star, color: Colors.amber),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardCategory(String categoria, String image, BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FilterRestaurant(
                      tipo: categoria,
                    )),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(categoria),
            Image.asset(
              image,
              width: 100,
              height: 100,
            )
          ],
        ),
      ),
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
            TitlePlaceholder(width: 200.0),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ContentPlaceholder(
                  lineType: ContentLineType.twoLines,
                ),
                ContentPlaceholder(
                  lineType: ContentLineType.twoLines,
                ),
                ContentPlaceholder(
                  lineType: ContentLineType.twoLines,
                ),
              ],
            ),
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
            Column(
              children: elementos
                  .map((item) => optionsFilter(item, context2))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget optionsFilter(String value, BuildContext context) {
    return ListTile(
      title: Text(
        value,
      ),
      leading: Radio(
        groupValue: _value,
        value: value,
        //groupValue: _value,
        activeColor: const Color(0xFF6200EE),
        onChanged: (value) {
          Navigator.pop(context);
          debugPrint(value.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FilterRestaurant(
                      tipo: value.toString(),
                    )),
          );
        },
      ),
    );
  }
}
