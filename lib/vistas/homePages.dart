import 'package:flutter/material.dart';
import 'home.dart';
import 'planes.dart';

class HomePages extends StatefulWidget {
  final int initialIndex;

  const HomePages({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    Planes(),
    // Agrega más vistas según sea necesario
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
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
        backgroundColor: Color(0xFFFFF854),
      ),
      body: Container(
        color: Color.fromARGB(255, 215, 214, 214),
        child: _screens[_selectedIndex],
      ),
      drawer: Container(
        width: 250, // Puedes ajustar este valor según tus necesidades
        child: _drawer(context),
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 233, 233, 233),
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
              leading: Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                navigateToIndex(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: const Text("Planes"),
              onTap: () {
                Navigator.pop(context);
                navigateToIndex(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
