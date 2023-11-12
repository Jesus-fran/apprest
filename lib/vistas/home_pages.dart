import 'package:baseapp/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'home.dart';
import 'planes.dart';

class HomePages extends StatefulWidget {
  final int initialIndex;

  const HomePages({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  HomePagesState createState() => HomePagesState();
}

class HomePagesState extends State<HomePages> {
  int _selectedIndex = 0;
  late final Box box;

  final List<Widget> _screens = [
    const Home(),
    const Planes(),
    // Agrega más vistas según sea necesario
  ];

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
        backgroundColor: const Color(0xFFFFF854),
      ),
      body: Container(
        color: Colors.white,
        child: _screens[_selectedIndex],
      ),
      drawer: SizedBox(
        width: 250, // Puedes ajustar este valor según tus necesidades
        child: _drawer(context),
      ),
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
}
