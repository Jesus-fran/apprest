import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaRestaurant extends StatefulWidget {
  const MapaRestaurant({Key? key}) : super(key: key);

  @override
  State<MapaRestaurant> createState() => _MapsServiceState();
}

class _MapsServiceState extends State<MapaRestaurant> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(16.9087174551633, -92.09459449875938),
    zoom: 14.4746,
  );

  static const CameraPosition _camarapositon = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(16.89584377624656, -92.06727491636889),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Mero Lek")),
        backgroundColor: const Color(0xFFFFF854),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.yellow,
        onPressed: _goToTheLake,
        label: const Text('Localizar'),
        icon: const Icon(Icons.location_on, color: Colors.redAccent),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_camarapositon));
  }
}
