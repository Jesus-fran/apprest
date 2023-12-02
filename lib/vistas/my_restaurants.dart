import 'dart:convert';
import 'dart:typed_data';

import 'package:baseapp/controladores/restaurant_controller.dart';
import 'package:baseapp/modelos/restaurant_model.dart';
import 'package:baseapp/vistas/admin_restaurant.dart';
import 'package:baseapp/vistas/home_pages.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MyRestaurants extends StatelessWidget {
  final Function onstateUpdate;
  final HomePages homePagesInstance;

  const MyRestaurants(
      {super.key,
      required this.onstateUpdate,
      required this.homePagesInstance});

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box('tokenBox');
    String tokenUser = box.get('token');

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: FutureBuilder<List<RestaurantModelo>>(
            future: getRestaurants(tokenUser),
            builder: (context, AsyncSnapshot<List<RestaurantModelo>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  if (!homePagesInstance.subs) {
                    Future.delayed(Duration.zero, () {
                      homePagesInstance.subs = true;
                      onstateUpdate(); // Llama a la función de actualización de estado
                    });
                  }
                  return const Text(
                    'Sin restaurante',
                    style: TextStyle(fontSize: 18),
                  );
                }

                if (snapshot.data![0].statusCode == 403) {
                  if (homePagesInstance.subs) {
                    Future.delayed(Duration.zero, () {
                      homePagesInstance.subs = false;
                      onstateUpdate(); // Llama a la función de actualización de estado
                    });
                  }
                  return Text(
                    snapshot.data![0].message!,
                    style: const TextStyle(fontSize: 18),
                  );
                }

                if (!homePagesInstance.subs) {
                  Future.delayed(Duration.zero, () {
                    homePagesInstance.subs = true;
                    onstateUpdate(); // Llama a la función de actualización de estado
                  });
                }
                return content(context, snapshot.data!);
              } else {
                return cargandoMessage(context);
              }
            }),
      ),
    );
  }

  Widget content(BuildContext context, List<RestaurantModelo> restaurants) {
    return RefreshIndicator(
        child: ListView(
          children: [
            const Text(
              'Mis restaurantes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: restaurants
                  .map((item) => myCard(
                      context,
                      item.restaurant ?? '',
                      item.logo,
                      AdminRestaurant(
                        restaurant:
                            item.restaurant != null ? item.restaurant! : '',
                        id: item.id_restaurant!,
                        updateState: onstateUpdate,
                      )))
                  .toList(),
            ),
          ],
        ),
        onRefresh: () {
          return Future(() {
            debugPrint('Refreshing..');
            onstateUpdate();
          });
        });
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

  Widget myCard(BuildContext context, title, image, Widget destino) {
    Uint8List decodeImageString(String imageString) {
      // Decodificar la cadena base64 a Uint8List
      return Uint8List.fromList(base64.decode(imageString));
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destino),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: image != null
                  ? Image.memory(decodeImageString(image), fit: BoxFit.cover)
                  : Image.asset(
                      'assets/imgnodisp.jpg',
                      fit: BoxFit.cover,
                    ),
            ),
            ListTile(
              title: Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
