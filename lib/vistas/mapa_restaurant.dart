import 'dart:async';

import 'package:PerfectConnection/controladores/restaurant_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

class MapaRestaurant extends StatefulWidget {
  final int id;
  final String name;
  const MapaRestaurant({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<MapaRestaurant> createState() => _MapsServiceState();
}

class _MapsServiceState extends State<MapaRestaurant> {
  final Completer<GoogleMapController> _controller = Completer();
  final String latitud = '';

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('tokenBox');
    String tokenUser = box.get('token');
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Ubicación de ${widget.name}")),
        backgroundColor: const Color(0xFFFFF854),
      ),
      body: FutureBuilder<dynamic>(
          future: getUbicacion(tokenUser, widget.id),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              CameraPosition kGooglePlex = CameraPosition(
                target: LatLng(double.parse(snapshot.data![0]['lat']),
                    double.parse(snapshot.data![0]['lon'])),
                zoom: 19.151926040649414,
              );
              return GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            } else {
              return cargandoMessage(context);
            }
          }),
    );
  }

  Widget cargandoMessage(context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 200),
          CircularProgressIndicator(
            color: Colors.amberAccent,
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}
