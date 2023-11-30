import 'package:baseapp/modelos/restaurant_model.dart';
import 'package:baseapp/vistas/eliminando_restaurant.dart';
import 'package:baseapp/vistas/home_pages.dart';
import 'package:baseapp/vistas/registrar_restaurante.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AdminRestaurant extends StatefulWidget {
  final String restaurant;
  final int id;
  final Function updateState;
  const AdminRestaurant(
      {super.key,
      required this.restaurant,
      required this.id,
      required this.updateState});

  @override
  State<AdminRestaurant> createState() => _AdminRestaurantState();
}

class _AdminRestaurantState extends State<AdminRestaurant> {
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordHidden = true;

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
            Colors.indigo,
            RegistrarRestaurante(
              id: widget.id,
              updateState: widget.updateState,
            )),
        const SizedBox(
          height: 20,
        ),
        myCard(context, 'Ubicación', Icons.location_on_rounded,
            Colors.redAccent, const HomePages()),
        const SizedBox(
          height: 20,
        ),
        myCard(context, 'Ofertas y menú', Icons.local_offer_rounded,
            Colors.deepOrange, const HomePages()),
        const SizedBox(
          height: 20,
        ),
        myCard(context, 'Reseñas y/o comentarios', Icons.comment_rounded,
            Colors.blueAccent, const HomePages()),
        const SizedBox(
          height: 20,
        ),
        myCard(context, 'Galería de fotos', Icons.photo_library_rounded,
            Colors.deepPurple, const HomePages()),
        const SizedBox(
          height: 40,
        ),
        Card(
          elevation: 2,
          shadowColor: Colors.redAccent,
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.redAccent)),
          margin: const EdgeInsets.all(10),
          borderOnForeground: false,
          child: InkWell(
            onTap: () {
              _showDialogDelete(context);
            },
            highlightColor: Colors.red.shade300,
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
                  Icon(Icons.delete_rounded, size: 35, color: Colors.red),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Eliminar restaurante",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget myCard(BuildContext context, title, IconData icon, Color colorIcon,
      Widget destino) {
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
              Icon(icon, size: 35, color: colorIcon),
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

  Future<void> _showDialogDelete(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              scrollable: true,
              title: const Text('Eliminar restaurante'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      'Por seguridad, debes ingresar tu contraseña para proceder con la eliminación.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: _formfield,
                      child: TextFormField(
                        maxLength: 30,
                        controller: _passwordController,
                        obscureText: passwordHidden,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Image.asset('assets/password.png',
                                width: 20, height: 20),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passwordHidden = !passwordHidden;
                              });
                            },
                            child: Icon(passwordHidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          hintText: "Contraseña",
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          bool passInvalid = RegExp(
                                  r"^(?=.*[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ])(?=.*\d)(?=.*[@$!%*?&^#/_.;\s:-])[a-zA-ZáéíóúüñÁÉÍÓÚÜÑ\d@$!%*?&^#/_.;\s:-]+$")
                              .hasMatch(value!);
                          if (value.isEmpty) {
                            return "Ingrese una contraseña";
                          } else if (value.length < 6) {
                            return "Al menos ingrese 6 caracteres.";
                          } else if (!passInvalid) {
                            return "Al menos una minúscula o mayúscula, un número y un caracter.";
                          } else {
                            return null;
                          }
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                      'Si continuas, toda la información asociada a este restaurante será eliminado permanentemente y de manera irreversible.'),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 228, 228, 228),
                          foregroundColor: Colors.black,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      child: const Center(child: Text("Cancelar")),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 245, 69, 69),
                          foregroundColor: Colors.white,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        if (_formfield.currentState!.validate()) {
                          Box box = Hive.box('tokenBox');
                          var tokenUser = box.get('token');
                          String password = _passwordController.text;
                          _passwordController.clear();
                          debugPrint("validado correctamente");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EliminandoRestaurant(
                                  tokenUser: tokenUser,
                                  info: RestaurantModelo(
                                      id_restaurant: widget.id),
                                  password: password,
                                ),
                              ));
                        }
                      },
                      child: const Center(child: Text("Eliminar restaurante")),
                    ),
                  ],
                )
              ],
            );
          });
        });
  }
}
