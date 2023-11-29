import 'package:baseapp/vistas/home_pages.dart';
import 'package:baseapp/vistas/registrar_restaurante.dart';
import 'package:flutter/material.dart';

class AdminRestaurant extends StatefulWidget {
  final String restaurant;
  final int id;
  final Function updateState;
  const AdminRestaurant(
      {super.key, required this.restaurant, required this.id, required this.updateState});

  @override
  State<AdminRestaurant> createState() => _AdminRestaurantState();
}

class _AdminRestaurantState extends State<AdminRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant),
        backgroundColor: const Color(0xFFFFF854),
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(children: [
        const Text(
          'Administra tu restaurante',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 20,
        ),
        myCard(
            context,
            'Información básica',
            Icons.home_work,
            RegistrarRestaurante(
              id: widget.id,updateState: widget.updateState,
            )),
        const SizedBox(
          height: 20,
        ),
        myCard(
            context, 'Ubicación', Icons.location_on_rounded, const HomePages()),
        const SizedBox(
          height: 20,
        ),
        myCard(context, 'Ofertas y menú', Icons.local_offer_rounded,
            const HomePages()),
        const SizedBox(
          height: 20,
        ),
        myCard(context, 'Reseñas y/o comentarios', Icons.comment_rounded,
            const HomePages()),
        const SizedBox(
          height: 20,
        ),
        myCard(context, 'Galería de fotos', Icons.photo_library_rounded,
            const HomePages()),
      ]),
    );
  }
}

Widget myCard(BuildContext context, title, IconData icon, Widget destino) {
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
      child: Container(
        width: double.maxFinite,
        height: 100,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(icon, size: 35),
            const SizedBox(
              width: 40,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    ),
  );
}
