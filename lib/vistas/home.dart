import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          backgroundColor: const Color(0xFFFFF854),
          title: const Center(
            child: Text("Bienvenido"),
          )),
      drawer: _drawer(),
      body: Center(
        child: _home(),
      ),
    );
  }
}



Widget _home() {
  return Column(
    children: [
      const Divider(
        height: 50,
        color: Colors.transparent,
      ),
      Expanded(
          child: RefreshIndicator(
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  Center(
                    child: Text("Hola"),
                  )
                ],
              ),
              onRefresh: () {
                return Future(() {
                  debugPrint("Actualiza pantalla");
                });
              })),
    ],
  );
}



Widget _drawer() {
  return Drawer(
    child: ListView(
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(color: Color(0xFFFFF854)),
          margin: EdgeInsets.only(bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Perfect Connection",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Icon(
                Icons.dining_outlined,
                size: 80.9,
                color: Colors.black,
              )
            ],
          ),
        ),
        const Text(
          "Crear un restaurante",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        ListTile(
          leading: const Icon(
            Icons.note,
            size: 30,
            color: Colors.black,
          ),
          title: const Text(
            "opción 1",
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.note,
            size: 30,
            color: Colors.black,
          ),
          title: const Text(
            "Opción 2",
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.note,
            size: 30,
            color: Colors.black,
          ),
          title: const Text(
            "Opción 3",
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {},
        ),
        const Divider(
          height: 10,
          color: Color.fromARGB(50, 151, 151, 151),
        ),
        const Text(
          "Empresa",
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        ListTile(
          leading: const Icon(
            Icons.group,
            size: 30,
            color: Colors.black,
          ),
          title: const Text(
            "Nosotros",
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.home_work_outlined,
            size: 30,
            color: Colors.black,
          ),
          title: const Text(
            "Contacto",
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {},
        ),
        const Divider(
          height: 10,
          color: Color.fromARGB(50, 151, 151, 151),
        ),
        const Text(
          "Cuenta",
          style: TextStyle(
              color: Color.fromARGB(255, 10, 10, 10),
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        ListTile(
          leading: const Icon(
            Icons.exit_to_app,
            size: 30,
            color: Colors.black,
          ),
          title: const Text(
            "Cerrar sesión",
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {},
        ),
      ],
    ),
  );
}

