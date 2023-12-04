import 'dart:convert';
import 'dart:typed_data';

import 'package:baseapp/controladores/restaurant_controller.dart';
import 'package:baseapp/modelos/restaurant_model.dart';
import 'package:baseapp/vistas/perfil_restaurant.dart';
import 'package:baseapp/vistas/placeholders_home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';

class FilterRestaurant extends StatefulWidget {
  final String tipo;
  const FilterRestaurant({super.key, required this.tipo});

  @override
  State<FilterRestaurant> createState() => _FilterRestaurantState();
}

class _FilterRestaurantState extends State<FilterRestaurant> {
  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('tokenBox');
    String tokenUser = box.get('token');
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Resultados del filtro")),
        backgroundColor: const Color(0xFFFFF854),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              FutureBuilder<List<RestaurantModelo>>(
                  future: getFilterRestaurant(tokenUser, widget.tipo),
                  builder: (context,
                      AsyncSnapshot<List<RestaurantModelo>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 200,
                            ),
                            Center(
                                child: Text(
                              'No hay negocios de este tipo',
                              style: TextStyle(fontSize: 18),
                            )),
                          ],
                        );
                      }
                      if (snapshot.data![0].statusCode == 422) {
                        //Si hubo un error de validación
                        return validationMessage(
                            snapshot.data![0].message!, context);
                      }
                      return content(snapshot.data!, context);
                    } else {
                      return skeletonLoad();
                    }
                  }),
            ],
          )),
    );
  }

  Widget content(List<RestaurantModelo> restaurants, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Negocios de ${widget.tipo}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 20,
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

  Widget skeletonLoad() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
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

  Widget validationMessage(String message, context) {
    void showAutoSnackBar(BuildContext context) {
      // Muestra si hay un error de validación
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SnackBar snack_1 = SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.redAccent, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 15),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack_1);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pop(context);
    });

    showAutoSnackBar(context);

    return Container();
  }
}
