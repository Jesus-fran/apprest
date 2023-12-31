import 'package:PerfectConnection/main.dart';
import 'package:PerfectConnection/modelos/restaurant_model.dart';
import 'package:PerfectConnection/vistas/creando_restaurant.dart';
import 'package:PerfectConnection/vistas/my_restaurants.dart';
import 'package:PerfectConnection/vistas/proximamente.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'home.dart';
import 'planes.dart';

class HomePages extends StatefulWidget {
  final int initialIndex;
  bool subs;

  HomePages({Key? key, this.initialIndex = 0, this.subs = true})
      : super(key: key);
  HomePages getInstance() {
    return this;
  }

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedIndex = 0;
  late final Box box;
  final _formfield = GlobalKey<FormState>();
  final TextEditingController _restaurantController = TextEditingController();

  // Vistas

  List<Widget Function(VoidCallback)> buildScreens() {
    final List<Widget Function(VoidCallback)> _screens = [
      (updateState) => Home(onstateUpdate: updateState),
      (updateState) => Planes(updateState: updateState),
      (updateState) => MyRestaurants(
            onstateUpdate: updateState,
            homePagesInstance: widget.getInstance(),
          ),
    ];
    return _screens;
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    super.initState();
    box = Hive.box('tokenBox');
  }

  void navigateToIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfect Conection"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Proximamente()),
                );
              },
              icon: const Icon(Icons.account_circle_sharp)),
        ],
        backgroundColor: const Color(0xFFFFF854),
      ),
      body: Container(
        color: const Color.fromARGB(255, 241, 241, 241),
        child: buildScreens()[_selectedIndex](updateState),
      ),
      drawer: SizedBox(
        width: 250,
        child: _drawer(context),
      ),
      floatingActionButton: _selectedIndex == 2 && widget.subs
          ? FloatingActionButton(
              onPressed: () {
                _showDialogNew(context);
              },
              backgroundColor: const Color(0xFFFFF854),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFFFF854)),
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Opciones",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                navigateToIndex(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Planes"),
              onTap: () {
                Navigator.pop(context);
                navigateToIndex(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant),
              title: const Text("Mi restaurante"),
              onTap: () {
                Navigator.pop(context);
                navigateToIndex(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Cerrar sesión"),
              onTap: () {
                box.delete('token');
                var token = box.get('token');
                debugPrint(token);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialogNew(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Nuevo restaurante'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                    key: _formfield,
                    child: TextFormField(
                      controller: _restaurantController,
                      autofocus: true,
                      maxLength: 50,
                      decoration:
                          const InputDecoration(labelText: 'Restaurante'),
                      validator: (value) {
                        bool textValid =
                            RegExp(r"^[A-Za-z0-9áéíóúÁÉÍÓÚñÑ\s¡!¿?.,]+$")
                                .hasMatch(value!);
                        if (!textValid && value != '') {
                          return "No debe ingresar caracteres especiales";
                        } else if (value == '') {
                          return 'Ingrese el nombre de su restaurante.';
                        } else if (value.length < 4) {
                          return 'Ingrese al menos 4 caracteres.';
                        } else {
                          return null;
                        }
                      },
                    ))
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
                        backgroundColor: const Color.fromARGB(255, 245, 69, 69),
                        foregroundColor: Colors.white,
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      if (_formfield.currentState!.validate()) {
                        var tokenUser = box.get('token');
                        String restaurant = _restaurantController.text;
                        _restaurantController.clear();
                        debugPrint("validado correctamente");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreandoRestaurant(
                                  tokenUser: tokenUser,
                                  info:
                                      RestaurantModelo(restaurant: restaurant),
                                  updateState: updateState),
                            ));
                      }
                    },
                    child: const Center(child: Text("Crear restaurante")),
                  ),
                ],
              )
            ],
          );
        });
  }

  void updateState() {
    setState(() {});
  }
}
