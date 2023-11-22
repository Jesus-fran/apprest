import 'package:baseapp/vistas/home_pages.dart';
import 'package:baseapp/vistas/registrar_restaurante.dart';
import 'package:flutter/material.dart';

class AdminRestaurant extends StatelessWidget {
  const AdminRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
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
        myCard(context, 'Información básica', Icons.home_work,
            const RegistrarRestaurante()),
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
}
